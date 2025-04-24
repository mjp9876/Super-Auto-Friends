extends Card


func die(killers):
	if not blocked_ability and inBattle:
		var damage_to_deal = 10
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var need_to_proc = false
		if upgraded:
			damage_to_deal = 20
		for i in range(killers.size()):
			if killers[i].hp > 0:
				proc()
				need_to_proc = true
				await attack_opponent(killers[i], damage_to_deal, arena_scene)
		if need_to_proc:
			await proc()
