extends Card


func die(_killer):
	if not blocked_ability and not upgraded and not inBattle:
		Manager.update_friends()
		for friend in Manager.friends:
			if friend != null:
				proc()
				friend.hp += 2
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "2")
				await get_tree().create_timer(0.2).timeout
				friend.setStatText()
		await proc()
	elif not blocked_ability and not upgraded and inBattle:
		var team_mates = []
		var arena_scene = get_tree().get_first_node_in_group("arena")
		find_team_mates(arena_scene, team_mates)
		for friend in team_mates:
			if friend != null:
				proc()
				friend.hp += 2
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "2")
				await get_tree().create_timer(0.2).timeout
				friend.setStatText()
		await proc()

func hurt(_hurter):
	if not blocked_ability and upgraded and not inBattle:
		Manager.update_friends()
		for friend in Manager.friends:
			if friend != null and friend != self:
				proc()
				friend.hp += 2
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "2")
				await get_tree().create_timer(0.2).timeout
				friend.setStatText()
		await proc()
	elif not blocked_ability and upgraded and inBattle:
		var team_mates = []
		var arena_scene = get_tree().get_first_node_in_group("arena")
		find_team_mates(arena_scene, team_mates)
		for friend in team_mates:
			if friend != null:
				quick_proc()
				friend.hp += 2
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "2")
				await get_tree().create_timer(0.1).timeout
				friend.setStatText()
		await quick_proc()

func find_team_mates(arena_scene, team_mates):
	match team_number:
		1:
			for opponent in arena_scene.p1cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent != self:
					team_mates.append(opponent)
		2:
			for opponent in arena_scene.p2cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent != self:
					team_mates.append(opponent)
		3:
			for opponent in arena_scene.p3cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent != self:
					team_mates.append(opponent)
		4:
			for opponent in arena_scene.p4cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent != self:
					team_mates.append(opponent)
