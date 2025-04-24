extends Card

func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var hp_to_give = 9
		var attack_to_give = 1
		var yellow_team_mates = []
		var need_to_proc = false
		if upgraded:
			hp_to_give = 17
			attack_to_give = 2
		find_yellow_team_mates(arena_scene, yellow_team_mates)
		for friend in yellow_team_mates:
			proc()
			need_to_proc = true
			friend.hp += hp_to_give
			Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, str(hp_to_give))
			await get_tree().create_timer(0.1).timeout
			friend.attack += attack_to_give
			Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, str(attack_to_give))
			await get_tree().create_timer(0.2).timeout
			friend.setStatText()
		if need_to_proc:
			await proc()

func find_yellow_team_mates(arena_scene, yellow_team_mates):
	match team_number:
		1:
			for opponent in arena_scene.p1cards:
				if opponent.card_name != "ghost" and opponent.colour == colours.YELLOW:
					yellow_team_mates.append(opponent)
		2:
			for opponent in arena_scene.p2cards:
				if opponent.card_name != "ghost" and opponent.colour == colours.YELLOW:
					yellow_team_mates.append(opponent)
		3:
			for opponent in arena_scene.p3cards:
				if opponent.card_name != "ghost" and opponent.colour == colours.YELLOW:
					yellow_team_mates.append(opponent)
		4:
			for opponent in arena_scene.p4cards:
				if opponent.card_name != "ghost" and opponent.colour == colours.YELLOW:
					yellow_team_mates.append(opponent)
