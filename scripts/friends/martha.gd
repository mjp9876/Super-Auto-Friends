extends Card


func end_turn():
	if not blocked_ability:
		Manager.update_friends()
		var target_friends = []
		var target_friend = null
		while target_friend == self or target_friend == null or target_friend in target_friends:
			target_friend = Manager.friends.pick_random()
		if Manager.prioritise_leader:
			target_friend = Manager.friends[0]
		target_friends.append(target_friend)
		if Manager.friends.count(null) < 4:
			while target_friend == self or target_friend == null or target_friend in target_friends:
				target_friend = Manager.friends.pick_random()
			target_friends.append(target_friend)
		if upgraded and Manager.friends.count(null) < 3:
			while target_friend == self or target_friend == null or target_friend in target_friends:
				target_friend = Manager.friends.pick_random()
			target_friends.append(target_friend)
		for friend in target_friends:
			proc()
			friend.attack += 1
			Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, "1")
			await get_tree().create_timer(0.2).timeout
			friend.setStatText()
		await proc()
