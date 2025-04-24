extends Card


func kill(dead_team, _dead_team_index):
	if not blocked_ability and inBattle:
		var damage_to_deal = 21
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var card_to_attack = null
		if upgraded:
			damage_to_deal = 39
		card_to_attack = find_target(arena_scene, dead_team)
		if card_to_attack != null:
			proc()
			await attack_opponent(card_to_attack, damage_to_deal, arena_scene)
			card_to_attack = null
			await proc()
			await get_tree().create_timer(0.35).timeout

func find_target(arena_scene, dead_team):
	var card_to_go_for = null
	match dead_team:
		1:
			for i in range(1, arena_scene.p1cards.size()):
				if arena_scene.p1cards[-i].card_name != "ghost" and arena_scene.p1cards[-i].hp > 0:
					card_to_go_for = arena_scene.p1cards[-i]
					break
		2:
			for i in range(1, arena_scene.p2cards.size()):
				if arena_scene.p2cards[-i].card_name != "ghost" and arena_scene.p2cards[-i].hp > 0:
					card_to_go_for = arena_scene.p2cards[-i]
					break
		3:
			for i in range(1, arena_scene.p3cards.size()):
				if arena_scene.p3cards[-i].card_name != "ghost" and arena_scene.p3cards[-i].hp > 0:
					card_to_go_for = arena_scene.p3cards[-i]
					break
		4:
			for i in range(1, arena_scene.p4cards.size()):
				if arena_scene.p4cards[-i].card_name != "ghost" and arena_scene.p4cards[-i].hp > 0:
					card_to_go_for = arena_scene.p4cards[-i]
					break
	return card_to_go_for
