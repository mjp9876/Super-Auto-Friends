extends Card

func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var stat_multiplier = 0
		stat_multiplier = find_colour_team_mates(arena_scene, colours.RED)
		if upgraded:
			stat_multiplier += find_colour_team_mates(arena_scene, colours.YELLOW)
		if stat_multiplier >= 1:
			proc()
			hp += 5 * stat_multiplier
			Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(stat_multiplier * 5))
			await get_tree().create_timer(0.2).timeout
			attack += stat_multiplier
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(stat_multiplier))
			setStatText()
			await proc()

func find_colour_team_mates(arena_scene, this_colour3):
	var red_team_mates_found = 0
	match team_number:
		1:
			for opponent in arena_scene.p1cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == this_colour3:
					red_team_mates_found += 1
		2:
			for opponent in arena_scene.p2cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == this_colour3:
					red_team_mates_found += 1
		3:
			for opponent in arena_scene.p3cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == this_colour3:
					red_team_mates_found += 1
		4:
			for opponent in arena_scene.p4cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == this_colour3:
					red_team_mates_found += 1
	return red_team_mates_found
