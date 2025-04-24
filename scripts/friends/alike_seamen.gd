extends Card


func end_turn():
	if not blocked_ability:
		Manager.update_friends()
		var target_friend = null
		var slot_position
		var search_position
		if not upgraded:
			while target_friend == self or target_friend == null:
				if Manager.prioritise_leader:
					target_friend = Manager.friends[0]
				else:
					target_friend = Manager.friends.pick_random()
		else:
			slot_position = Manager.friends.find(self)
			search_position = slot_position + 1
			while search_position < 6:
				if Manager.friends[search_position] == null:
					search_position += 1
				else:
					target_friend = Manager.friends[search_position]
					break
		if target_friend != null:
			proc()
			target_friend.attack += 1
			Manager.move_symbol(global_position, target_friend.global_position, most_attack_target_texture, "1")
			target_friend.setStatText()
			await proc()
