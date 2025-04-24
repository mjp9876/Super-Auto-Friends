extends Card


func buy():
	if not blocked_ability and not upgraded:
		var possible_friends = []
		Manager.update_friends()
		for friend in Manager.friends:
			if friend != null and friend != self:
				possible_friends.append(friend)
		possible_friends.shuffle()
		print(possible_friends)
		if possible_friends.size() > 3:
			possible_friends = possible_friends.slice(0, 3)
			print(possible_friends)
			if Manager.friends[0] not in possible_friends and Manager.prioritise_leader:
				possible_friends[0] = Manager.friends[0]
		for friend in possible_friends:
			proc()
			friend.hp = max(1, friend.hp - 3)
			Manager.move_symbol(global_position, friend.global_position, least_hp_target_texture, "3")
			await get_tree().create_timer(0.15).timeout
			friend.attack += 2
			Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, "2")
			await get_tree().create_timer(0.15).timeout
			friend.setStatText()
		await proc()

func start_battle():
	if not blocked_ability and upgraded:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var friends_to_buff = []
		await find_team_mates(arena_scene, friends_to_buff)
		for friend in friends_to_buff:
			proc()
			friend.hp = max(1, friend.hp - 3)
			Manager.move_symbol(global_position, friend.global_position, least_hp_target_texture, "3")
			await get_tree().create_timer(0.15).timeout
			friend.attack += 2
			Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, "2")
			await get_tree().create_timer(0.15).timeout
			friend.setStatText()
		await proc()

func find_team_mates(arena_scene, possible_targets):
	match team_number:
		1:
			for opponent in arena_scene.p1cards:
				if opponent.card_name != "ghost" and opponent.hp > 0:
					possible_targets.append(opponent)
		2:
			for opponent in arena_scene.p2cards:
				if opponent.card_name != "ghost" and opponent.hp > 0:
					possible_targets.append(opponent)
		3:
			for opponent in arena_scene.p3cards:
				if opponent.card_name != "ghost" and opponent.hp > 0:
					possible_targets.append(opponent)
		4:
			for opponent in arena_scene.p4cards:
				if opponent.card_name != "ghost" and opponent.hp > 0:
					possible_targets.append(opponent)
