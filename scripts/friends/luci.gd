extends Card

func card_specific_rng():
	didnt_win_last_battle = true
	if Manager.playerNum in Manager.previous_round_winner:
		didnt_win_last_battle = false
	else:
		didnt_win_last_battle = true

func start_battle():
	if not blocked_ability:
		var percentage_damage_to_deal = 0.0
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		var possible_targets_separate_teams = [[], [], [] ,[]]
		var percentage_damage_to_deal_separate_teams = [0.0, 0.0, 0.0, 0.0]
		var need_to_proc = false
		if upgraded or didnt_win_last_battle:
			find_possible_targets_separate_teams(arena_scene, possible_targets_separate_teams)
			for team in possible_targets_separate_teams:
				team.sort_custom(sort_hp)
				if team.size() > 0:
					match team[0].team_number:
						1:
							percentage_damage_to_deal_separate_teams[0] = float(arena_scene.p1stats[arena_scene.WINS]) * 0.1
						2:
							percentage_damage_to_deal_separate_teams[1] = float(arena_scene.p2stats[arena_scene.WINS]) * 0.1
						3:
							percentage_damage_to_deal_separate_teams[2] = float(arena_scene.p3stats[arena_scene.WINS]) * 0.1
						4:
							percentage_damage_to_deal_separate_teams[3] = float(arena_scene.p4stats[arena_scene.WINS]) * 0.1
			for i in range(4):
				if (i + 1) != team_number:
					if possible_targets_separate_teams[i].size() > 0 and percentage_damage_to_deal_separate_teams[i] > 0:
						proc()
						need_to_proc = true
						await reduce_hp(possible_targets_separate_teams[i][0], percentage_damage_to_deal_separate_teams[i])
						await get_tree().create_timer(0.2).timeout
		if need_to_proc:
			await proc()

func sort_hp(a, b):
	if a.hp > b.hp:
		return true
	return false

func find_possible_targets_separate_teams(arena_scene, possible_targets):
	if team_number != 1:
		for opponent in arena_scene.p1cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets[0].append(opponent)
	if team_number != 2:
		for opponent in arena_scene.p2cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets[1].append(opponent)
	if team_number != 3:
		for opponent in arena_scene.p3cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets[2].append(opponent)
	if team_number != 4:
		for opponent in arena_scene.p4cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets[3].append(opponent)

func find_possible_targets(arena_scene, possible_targets):
	if team_number != 1:
		for opponent in arena_scene.p1cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)
	if team_number != 2:
		for opponent in arena_scene.p2cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)
	if team_number != 3:
		for opponent in arena_scene.p3cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)
	if team_number != 4:
		for opponent in arena_scene.p4cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)

func reduce_hp(opponent, percentage_damage_to_deal):
	opponent.hp -= int(opponent.hp * percentage_damage_to_deal)
	await Manager.move_symbol(global_position, opponent.global_position, least_hp_target_texture, str(percentage_damage_to_deal * 100) + "%")
	await get_tree().create_timer(0.2).timeout
	if opponent.hp <= 0:
		opponent.hp = 1
	opponent.setStatText()


