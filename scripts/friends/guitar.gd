extends Card


func die(_killers):
	if not blocked_ability and inBattle:
		var damage_to_deal = 4
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		var need_to_proc = false
		if upgraded:
			damage_to_deal = 8
		find_possible_targets(arena_scene, possible_targets)
		possible_targets.sort_custom(sort_hp)
		while possible_targets.size() > 0:
			proc()
			need_to_proc = true
			await attack_opponent(possible_targets[0], damage_to_deal, arena_scene)
			await get_tree().create_timer(0.1).timeout
			possible_targets.pop_front()
		if need_to_proc:
			await proc()

func sort_hp(a, b):
	if a.hp > b.hp:
		return true
	return false

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
