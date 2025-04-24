extends Card


func card_specific_rng():
	attack_order = []
	attack_order_possibilities = range(18)
	for i in range((hp + 6) * (x + 6)):
		attack_order.append(attack_order_possibilities.pick_random())

func friend_ahead_attacks(_friend_ahead):
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		var damage_to_deal = 28
		if upgraded:
			damage_to_deal = 48
		find_possible_targets(arena_scene, possible_targets)
		if possible_targets.size() > 0:
			while possible_targets.size() <= attack_order[0]:
				attack_order.pop_front()
			proc()
			await attack_opponent(possible_targets[attack_order[0]], damage_to_deal, arena_scene)
			attack_order.pop_front()
			possible_targets.clear()
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
