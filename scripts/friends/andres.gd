extends Card


func start_battle():
	if not blocked_ability:
		var damage_to_deal = 8
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		if upgraded:
			damage_to_deal = 16
		for i in range(3):
			find_possible_targets(arena_scene, possible_targets)
			possible_targets.sort_custom(sort_hp)
			if possible_targets.size() > 0:
				proc()
				await attack_opponent(possible_targets[0], damage_to_deal, arena_scene)
				await get_tree().create_timer(0.2).timeout
				possible_targets.clear()
		await proc()

func sort_hp(a, b):
	if a.hp < b.hp:
		return true
	return false

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


