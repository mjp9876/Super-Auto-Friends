extends Card


func before_attack():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		var damage_to_deal = 12
		var need_to_proc = false
		if upgraded:
			damage_to_deal = 25
		find_possible_targets(arena_scene, possible_targets)
		possible_targets.sort_custom(sort_hp)
		for opponent in possible_targets:
			need_to_proc = true
			proc()
			await attack_opponent(opponent, damage_to_deal, arena_scene)
			await get_tree().create_timer(0.2).timeout
			if opponent.hp > 0:
				opponent.colour = colour
				Manager.move_symbol(global_position, opponent.global_position, find_colour_icon(colour), "")
				opponent.setColour()
				await get_tree().create_timer(0.2).timeout
		if need_to_proc:
			await proc()

func find_possible_targets(arena_scene, possible_targets):
	if team_number != 1:
		if arena_scene.p1cards[0].card_name != "ghost" and arena_scene.p1cards[0].hp > 0 and arena_scene.p1cards[0].colour != colour:
			possible_targets.append(arena_scene.p1cards[0])
	if team_number != 2:
		if arena_scene.p2cards[0].card_name != "ghost" and arena_scene.p2cards[0].hp > 0 and arena_scene.p2cards[0].colour != colour:
			possible_targets.append(arena_scene.p2cards[0])
	if team_number != 3:
		if arena_scene.p3cards[0].card_name != "ghost" and arena_scene.p3cards[0].hp > 0 and arena_scene.p3cards[0].colour != colour:
			possible_targets.append(arena_scene.p3cards[0])
	if team_number != 4:
		if arena_scene.p4cards[0].card_name != "ghost" and arena_scene.p4cards[0].hp > 0 and arena_scene.p4cards[0].colour != colour:
			possible_targets.append(arena_scene.p4cards[0])

func sort_hp(a, b):
	if a.hp < b.hp:
		return true
	return false
