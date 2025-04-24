extends Card


func die(killers):
	if not blocked_ability and inBattle:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		if not upgraded:
			await kill_cards(killers, arena_scene)
		else:
			find_possible_targets(arena_scene, possible_targets)
			await kill_cards(possible_targets, arena_scene)

func kill_cards(cards_to_kill, arena_scene):
	var need_to_proc = false
	var damage_to_deal
	for i in range(cards_to_kill.size()):
		if cards_to_kill[i].hp > 0:
			proc()
			need_to_proc = true
			damage_to_deal = cards_to_kill[i].hp
			await attack_opponent(cards_to_kill[i], damage_to_deal, arena_scene)
	if need_to_proc:
		await proc()

func find_possible_targets(arena_scene, possible_targets):
	if arena_scene.p1cards[0].card_name != "ghost" and arena_scene.p1cards[0].hp > 0:
		possible_targets.append(arena_scene.p1cards[0])
	if arena_scene.p2cards[0].card_name != "ghost" and arena_scene.p2cards[0].hp > 0:
		possible_targets.append(arena_scene.p2cards[0])
	if arena_scene.p3cards[0].card_name != "ghost" and arena_scene.p3cards[0].hp > 0:
		possible_targets.append(arena_scene.p3cards[0])
	if arena_scene.p4cards[0].card_name != "ghost" and arena_scene.p4cards[0].hp > 0:
		possible_targets.append(arena_scene.p4cards[0])
