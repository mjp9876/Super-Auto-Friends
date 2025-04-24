extends Card


func start_turn():
	if not blocked_ability:
		await Manager.update_friends()
		var target_friend1 = null
		var target_friend2 = null
		var slot_position
		var search_position
		slot_position = Manager.friends.find(self)
		search_position = slot_position + 1
		while search_position < 6:
			if Manager.friends[search_position] == null:
				search_position += 1
			else:
				if target_friend1 == null:
					target_friend1 = Manager.friends[search_position]
					search_position += 1
					if not upgraded:
						break
				else:
					target_friend2 = Manager.friends[search_position]
					break
		if target_friend1 != null:
			proc()
			target_friend1.attack += 1
			Manager.move_symbol(global_position, target_friend1.global_position, most_attack_target_texture, "1")
			target_friend1.setStatText()
			if target_friend2 != null:
				await get_tree().create_timer(0.2).timeout
				target_friend2.attack += 1
				Manager.move_symbol(global_position, target_friend2.global_position, most_attack_target_texture, "1")
				target_friend2.setStatText()
			await proc()
