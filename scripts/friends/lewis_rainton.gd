extends Card


func before_attack():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		var times_to_attack = 1
		if upgraded:
			times_to_attack = 2
		for i in range(times_to_attack):
			proc()
			find_possible_targets(arena_scene, possible_targets)
			possible_targets.sort_custom(sort_hp)
			await attack_opponent(possible_targets[0], 4, arena_scene)
			await get_tree().create_timer(0.2).timeout
			possible_targets.clear()
		await proc()

func find_possible_targets(arena_scene, possible_targets):
	if team_number != 1:
		if arena_scene.p1cards[0].card_name != "ghost" and arena_scene.p1cards[0].hp > 0:
			possible_targets.append(arena_scene.p1cards[0])
	if team_number != 2:
		if arena_scene.p2cards[0].card_name != "ghost" and arena_scene.p2cards[0].hp > 0:
			possible_targets.append(arena_scene.p2cards[0])
	if team_number != 3:
		if arena_scene.p3cards[0].card_name != "ghost" and arena_scene.p3cards[0].hp > 0:
			possible_targets.append(arena_scene.p3cards[0])
	if team_number != 4:
		if arena_scene.p4cards[0].card_name != "ghost" and arena_scene.p4cards[0].hp > 0:
			possible_targets.append(arena_scene.p4cards[0])

func sort_hp(a, b):
	if a.hp < b.hp:
		return true
	return false
