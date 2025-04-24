extends Card


func hurt(attacker):
	if not blocked_ability and attacker.hp > 0:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var damage_to_deal = 4
		if upgraded:
			damage_to_deal = 8
		quick_proc()
		await attack_opponent(attacker, damage_to_deal, arena_scene)
		await quick_proc()
