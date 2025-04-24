extends Card


func die(killers):
	if not blocked_ability and inBattle:
		var damage_to_deal = n
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var card_to_attack = null
		for i in range(killers.size()):
			card_to_attack = find_target(arena_scene, killers[i])
			if card_to_attack != null:
				proc()
				await attack_opponent(card_to_attack, damage_to_deal, arena_scene)
				card_to_attack = null
				await proc()
				await get_tree().create_timer(0.35).timeout
		n = 10

func hurt(_attacker):
	if not blocked_ability:
		if not upgraded:
			n += 4
		else:
			n += 8
		await setAbilityText()

func find_target(arena_scene, killer):
	var card_to_go_for = null
	match killer.team_number:
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
