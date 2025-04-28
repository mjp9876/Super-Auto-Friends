extends Card


func kill(dead_team, _dead_team_index):
	if not blocked_ability and inBattle:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		var damage_to_deal = 24
		var need_to_proc = false
		n += 1
		if upgraded:
			damage_to_deal = 44
		possible_targets = find_target(arena_scene, dead_team)
		if n >= 2:
			n -= 2
			for i in range(possible_targets.size()):
				if possible_targets[i].hp > 0:
					proc()
					need_to_proc = true
					await attack_opponent(possible_targets[i], damage_to_deal, arena_scene)
		if need_to_proc:
			await proc()

func find_target(arena_scene, dead_team):
	var cards_to_go_for = []
	if team_number != 1 and dead_team != 1:
		for i in range(arena_scene.p1cards.size()):
			if arena_scene.p1cards[i].card_name != "ghost" and arena_scene.p1cards[i].hp > 0:
				cards_to_go_for.append(arena_scene.p1cards[i])
				break
	if team_number != 2 and dead_team != 2:
		for i in range(arena_scene.p2cards.size()):
			if arena_scene.p2cards[i].card_name != "ghost" and arena_scene.p2cards[i].hp > 0:
				cards_to_go_for.append(arena_scene.p2cards[i])
				break
	if team_number != 3 and dead_team != 3:
		for i in range(arena_scene.p3cards.size()):
			if arena_scene.p3cards[i].card_name != "ghost" and arena_scene.p3cards[i].hp > 0:
				cards_to_go_for.append(arena_scene.p3cards[i])
				break
	if team_number != 4 and dead_team != 4:
		for i in range(arena_scene.p4cards.size()):
			if arena_scene.p4cards[i].card_name != "ghost" and arena_scene.p4cards[i].hp > 0:
				cards_to_go_for.append(arena_scene.p4cards[i])
				break
	return cards_to_go_for
