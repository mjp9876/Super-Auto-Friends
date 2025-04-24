extends Card


func end_turn():
	if not blocked_ability:
		Manager.update_friends()
		var target_friend1 = null
		var target_friend2 = null
		var slot_position
		var search_position
		var need_to_proc = false
		if not upgraded:
			while target_friend1 == self or target_friend1 == null:
				if Manager.prioritise_leader:
					target_friend1 = Manager.friends[0]
				else:
					target_friend1 = Manager.friends.pick_random()
			while target_friend2 == self or target_friend2 == null or target_friend2 == target_friend1:
				target_friend2 = Manager.friends.pick_random()
		else:
			slot_position = Manager.friends.find(self)
			search_position = slot_position + 1
			while search_position < 6:
				if Manager.friends[search_position] == null:
					search_position += 1
				else:
					target_friend1 = Manager.friends[search_position]
					break
			slot_position = Manager.friends.find(target_friend1)
			search_position = slot_position + 1
			while search_position < 6:
				if Manager.friends[search_position] == null:
					search_position += 1
				else:
					target_friend2 = Manager.friends[search_position]
					break
		if target_friend1 != null:
			proc()
			need_to_proc = true
			target_friend1.hp += 2
			Manager.move_symbol(global_position, target_friend1.global_position, most_hp_target_texture, "2")
			target_friend1.setStatText()
		if target_friend2 != null:
			await get_tree().create_timer(0.2).timeout
			target_friend2.hp += 2
			Manager.move_symbol(global_position, target_friend2.global_position, most_hp_target_texture, "2")
			target_friend2.setStatText()
		if need_to_proc:
			await proc()
