extends Card


func card_specific_rng():
	attack_order = [[], [], []]
	attack_order_possibilities = range(6)
	for j in range(3):
		for i in range((hp + 6) * (x + 6)):
			attack_order[j].append(attack_order_possibilities.pick_random())

func start_turn():
	if not blocked_ability:
		var n_increase = 3
		if upgraded:
			n_increase = 6
		n += n_increase
		setAbilityText()
		Manager.move_symbol(global_position, global_position, plus_icon, "")
		await proc()

func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = [[], [], []]
		var need_to_proc = false
		find_possible_targets(arena_scene, possible_targets)
		for i in range(3):
			if possible_targets[i].size() > 0:
				while possible_targets[i].size() <= attack_order[i][0]:
					attack_order[i].pop_front()
				proc()
				need_to_proc = true
				await attack_opponent(possible_targets[i][attack_order[i][0]], n, arena_scene)
				await get_tree().create_timer(0.2).timeout
				attack_order[i].pop_front()
			possible_targets[i].clear()
		if need_to_proc:
			await proc()

func find_possible_targets(arena_scene, possible_targets):
	var possible_target_index = 0
	if team_number != 1:
		for opponent in arena_scene.p1cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets[possible_target_index].append(opponent)
		possible_target_index += 1
	if team_number != 2:
		for opponent in arena_scene.p2cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets[possible_target_index].append(opponent)
		possible_target_index += 1
	if team_number != 3:
		for opponent in arena_scene.p3cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets[possible_target_index].append(opponent)
		possible_target_index += 1
	if team_number != 4:
		for opponent in arena_scene.p4cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets[possible_target_index].append(opponent)
