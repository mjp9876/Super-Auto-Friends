extends Card


func kill(dead_team, dead_team_index):
	if not blocked_ability:
		match dead_team:
			1:
				if Manager.saved_team1[dead_team_index] != null:
					Manager.saved_team1[dead_team_index]["colour"] = colours.GREEN
			2:
				if Manager.saved_team2[dead_team_index] != null:
					Manager.saved_team2[dead_team_index]["colour"] = colours.GREEN
			3:
				if Manager.saved_team3[dead_team_index] != null:
					Manager.saved_team3[dead_team_index]["colour"] = colours.GREEN
			4:
				if Manager.saved_team4[dead_team_index] != null:
					Manager.saved_team4[dead_team_index]["colour"] = colours.GREEN

func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var attack_to_gain = 0
		attack_to_gain = find_green_opponents(arena_scene)
		attack_to_gain *= 2
		if upgraded:
			attack_to_gain *= 2
		if attack_to_gain > 0:
			attack += attack_to_gain
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_to_gain))
			setStatText()
			await proc()

func find_green_opponents(arena_scene):
	var found_greens = 0
	if team_number != 1:
		for opponent in arena_scene.p1cards:
			if opponent.card_name != "ghost" and opponent.colour == colours.GREEN:
				found_greens += 1
	if team_number != 2:
		for opponent in arena_scene.p2cards:
			if opponent.card_name != "ghost" and opponent.colour == colours.GREEN:
				found_greens += 1
	if team_number != 3:
		for opponent in arena_scene.p3cards:
			if opponent.card_name != "ghost" and opponent.colour == colours.GREEN:
				found_greens += 1
	if team_number != 4:
		for opponent in arena_scene.p4cards:
			if opponent.card_name != "ghost" and opponent.colour == colours.GREEN:
				found_greens += 1
	return found_greens
