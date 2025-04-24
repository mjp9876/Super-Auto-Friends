extends Card


func end_turn():
	if not blocked_ability:
		Manager.update_friends()
		var target_friends = []
		var target_friend = null
		var friends_to_buff = 2
		var hp_to_give = 3
		if upgraded:
			friends_to_buff = 4
			hp_to_give = 4
		for i in range(min(friends_to_buff, (5 - Manager.friends.count(null)))):
			while target_friend == self or target_friend == null or target_friend in target_friends:
				if Manager.prioritise_leader and Manager.friends[0] not in target_friends:
					target_friend = Manager.friends[0]
				else:
					target_friend = Manager.friends.pick_random()
			target_friends.append(target_friend)
			target_friend = null
		for friend in target_friends:
			proc()
			friend.hp += hp_to_give
			Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, str(hp_to_give))
			await get_tree().create_timer(0.15).timeout
			friend.attack += 1
			Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, "1")
			await get_tree().create_timer(0.15).timeout
			friend.setStatText()
		await proc()
