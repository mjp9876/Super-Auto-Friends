extends Card


func card_specific_rng():
	target_teams = []
	possible_target_teams = [1, 2, 3, 4]
	target_teams.clear()
	for i in range(40):
		target_teams.append(possible_target_teams.pick_random())

func start_battle():
	if not blocked_ability:
		var damage_to_deal = 14
		var times_to_deal_damage = 3
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var card_to_attack = null
		while team_number in target_teams:
			target_teams.erase(team_number)
		if upgraded:
			damage_to_deal = 17
			times_to_deal_damage = 4
		for i in range(times_to_deal_damage):
			proc()
			card_to_attack = find_target(arena_scene, target_teams.pop_front())
			if card_to_attack != null:
				proc()
				await attack_opponent(card_to_attack, damage_to_deal, arena_scene)
				card_to_attack = null
				await get_tree().create_timer(0.2).timeout
		await proc()

func find_target(arena_scene, dead_team):
	var card_to_go_for = null
	match dead_team:
		1:
			for i in range(1, arena_scene.p1cards.size() + 1):
				if arena_scene.p1cards[-i].card_name != "ghost" and arena_scene.p1cards[-i].hp > 0:
					card_to_go_for = arena_scene.p1cards[-i]
					break
		2:
			for i in range(1, arena_scene.p2cards.size() + 1):
				if arena_scene.p2cards[-i].card_name != "ghost" and arena_scene.p2cards[-i].hp > 0:
					card_to_go_for = arena_scene.p2cards[-i]
					break
		3:
			for i in range(1, arena_scene.p3cards.size() + 1):
				if arena_scene.p3cards[-i].card_name != "ghost" and arena_scene.p3cards[-i].hp > 0:
					card_to_go_for = arena_scene.p3cards[-i]
					break
		4:
			for i in range(1, arena_scene.p4cards.size() + 1):
				if arena_scene.p4cards[-i].card_name != "ghost" and arena_scene.p4cards[-i].hp > 0:
					card_to_go_for = arena_scene.p4cards[-i]
					break
	return card_to_go_for
