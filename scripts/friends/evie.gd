extends Card


func card_specific_rng():
	colour_order = []
	this_colour = colours.CHANGE
	for i in range((hp + 3) * (x + 3)):
		while this_colour == colours.CHANGE or this_colour == colours.ITEM:
			this_colour = colours.values().pick_random()
		colour_order.append(this_colour)
		this_colour = colours.CHANGE

func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var cards_to_buff = []
		find_possible_targets(arena_scene, cards_to_buff)
		for character in cards_to_buff:
			proc()
			if upgraded:
				character.attack += 3
				Manager.move_symbol(global_position, character.global_position, most_attack_target_texture, "3")
				await get_tree().create_timer(0.1).timeout
			character.x += 3
			character.this_x = character.x
			Manager.move_symbol(global_position, character.global_position, x_icon, "")
			await get_tree().create_timer(0.1).timeout
			character.setStatText()
		await proc()

func kill(dead_team, dead_team_index):
	if not blocked_ability and upgraded:
		match dead_team:
			1:
				if Manager.saved_team1[dead_team_index] != null:
					while Manager.saved_team1[dead_team_index]["colour"] == colour_order[0]:
						colour_order.pop_front()
					Manager.saved_team1[dead_team_index]["colour"] = colour_order[0]
			2:
				if Manager.saved_team2[dead_team_index] != null:
					while Manager.saved_team2[dead_team_index]["colour"] == colour_order[0]:
						colour_order.pop_front()
					Manager.saved_team2[dead_team_index]["colour"] = colour_order[0]
			3:
				if Manager.saved_team3[dead_team_index] != null:
					while Manager.saved_team3[dead_team_index]["colour"] == colour_order[0]:
						colour_order.pop_front()
					Manager.saved_team3[dead_team_index]["colour"] = colour_order[0]
			4:
				if Manager.saved_team4[dead_team_index] != null:
					while Manager.saved_team4[dead_team_index]["colour"] == colour_order[0]:
						colour_order.pop_front()
					Manager.saved_team4[dead_team_index]["colour"] = colour_order[0]
		colour_order.pop_front()

func find_possible_targets(arena_scene, possible_targets):
	for opponent in arena_scene.p1cards:
		if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.RED:
			possible_targets.append(opponent)
	for opponent in arena_scene.p2cards:
		if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.RED:
			possible_targets.append(opponent)
	for opponent in arena_scene.p3cards:
		if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.RED:
			possible_targets.append(opponent)
	for opponent in arena_scene.p4cards:
		if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.RED:
			possible_targets.append(opponent)
