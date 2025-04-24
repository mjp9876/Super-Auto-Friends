extends Card


func card_specific_rng():
	attack_order = []
	attack_order_possibilities = range(18)
	for i in range((hp + 6) * (x + 8)):
		attack_order.append(attack_order_possibilities.pick_random())

func die(_killers):
	if not blocked_ability and inBattle:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		var damage_to_deal = 10
		var times_to_deal_damage = 4
		var need_to_proc = false
		if upgraded:
			damage_to_deal = 14
			times_to_deal_damage = 7
		for i in range(times_to_deal_damage):
			find_possible_targets(arena_scene, possible_targets)
			if possible_targets.size() > 0:
				while possible_targets.size() <= attack_order[0]:
					attack_order.pop_front()
				proc()
				need_to_proc = true
				await attack_opponent(possible_targets[attack_order[0]], damage_to_deal, arena_scene)
				await get_tree().create_timer(0.1).timeout
				attack_order.pop_front()
			possible_targets.clear()
		if need_to_proc:
			await proc()

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
