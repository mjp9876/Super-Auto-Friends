extends Card


func end_turn():
	if not blocked_ability:
		var taken_colours = []
		var attempted_friends = []
		var target_friends = []
		var attempt = 0
		Manager.update_friends()
		while attempted_friends.size() < 6 and taken_colours.size() < 4:
			attempt = rng.randi_range(0, 5)
			if Manager.prioritise_leader and attempted_friends.size() == 0:
				attempt = 0
			if attempt not in attempted_friends:
				attempted_friends.append(attempt)
				if Manager.friends[attempt] != self and Manager.friends[attempt] != null:
					if Manager.friends[attempt].colour not in taken_colours:
						taken_colours.append(Manager.friends[attempt].colour)
						target_friends.append(Manager.friends[attempt])
		for friend in target_friends:
			proc()
			if upgraded:
				friend.hp += 2
				friend.attack += 1
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "2")
				await get_tree().create_timer(0.2).timeout
				Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, "1")
				friend.setStatText()
			else:
				friend.hp += 3
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "3")
				await get_tree().create_timer(0.2).timeout
				friend.setStatText()
		await proc()
