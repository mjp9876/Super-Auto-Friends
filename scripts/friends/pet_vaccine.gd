extends Card


func end_turn():
	if not blocked_ability:
		var target_friend = []
		var search_position
		search_position = 5
		while search_position >= 0:
			if Manager.friends[search_position] != null and Manager.friends[search_position].hp > 0:
				target_friend.append(Manager.friends[search_position])
				break
			else:
				search_position -= 1
		for friend in target_friend:
			proc()
			if upgraded:
				friend.hp += 5
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "5")
				await get_tree().create_timer(0.2).timeout
			friend.attack += 1
			Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, "1")
			friend.setStatText()
			await get_tree().create_timer(0.2).timeout
		await proc()
