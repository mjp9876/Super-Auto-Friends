extends Card


func kill(dead_team, dead_team_index):
	if not blocked_ability:
		match dead_team:
			1:
				if Manager.saved_team1[dead_team_index] != null:
					Manager.saved_team1[dead_team_index]["colour"] = colours.YELLOW
			2:
				if Manager.saved_team2[dead_team_index] != null:
					Manager.saved_team2[dead_team_index]["colour"] = colours.YELLOW
			3:
				if Manager.saved_team3[dead_team_index] != null:
					Manager.saved_team3[dead_team_index]["colour"] = colours.YELLOW
			4:
				if Manager.saved_team4[dead_team_index] != null:
					Manager.saved_team4[dead_team_index]["colour"] = colours.YELLOW

func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var teams_with_yellow = [false, false, false, false]
		var money_to_gain = 0
		for card in Manager.teamP1:
			if card != null and card.colour == colours.YELLOW:
				teams_with_yellow[0] = true
		for card in Manager.teamP2:
			if card != null and card.colour == colours.YELLOW:
				teams_with_yellow[1] = true
		for card in Manager.teamP3:
			if card != null and card.colour == colours.YELLOW:
				teams_with_yellow[2] = true
		for card in Manager.teamP4:
			if card != null and card.colour == colours.YELLOW:
				teams_with_yellow[3] = true
		money_to_gain = teams_with_yellow.count(true)
		if upgraded:
			money_to_gain *= 2
		if money_to_gain > 0:
			proc()
			match team_number:
				1:
					get_the_money(arena_scene, arena_scene.p1stats, money_to_gain, 0)
				2:
					get_the_money(arena_scene, arena_scene.p2stats, money_to_gain, 1)
				3:
					get_the_money(arena_scene, arena_scene.p3stats, money_to_gain, 2)
				4:
					get_the_money(arena_scene, arena_scene.p4stats, money_to_gain, 3)
			await proc()

func get_the_money(arena_scene, player_stat_array, money_to_gain, coin_index):
	player_stat_array[arena_scene.MONEY] += money_to_gain
	arena_scene.update_text()
	Manager.move_symbol(global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_to_gain))

