extends Card

func start_battle():
	if not blocked_ability:
		var highest_win_number = 10
		var wins_to_subtract
		var player_wins = [0, 0, 0, 0]
		var attack_to_gain
		var arena_scene = get_tree().get_first_node_in_group("arena")
		player_wins[0] = arena_scene.p1stats[0]
		player_wins[1] = arena_scene.p2stats[0]
		player_wins[2] = arena_scene.p3stats[0]
		player_wins[3] = arena_scene.p4stats[0]
		wins_to_subtract = player_wins[team_number - 1]
		if not upgraded:
			player_wins.sort()
			highest_win_number = player_wins[-1]
		attack_to_gain = highest_win_number - wins_to_subtract
		if attack_to_gain > 0:
			attack += attack_to_gain
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_to_gain))
			setStatText()
			await proc()
