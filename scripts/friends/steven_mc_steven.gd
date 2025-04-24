extends Card

func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var cards_to_buff = []
		var attack_to_give = 1
		if upgraded:
			attack_to_give = 2
		find_possible_targets(arena_scene, cards_to_buff)
		for character in cards_to_buff:
			proc()
			character.attack += 1
			Manager.move_symbol(global_position, character.global_position, most_attack_target_texture, str(attack_to_give))
			await get_tree().create_timer(0.1).timeout
			character.setStatText()
		await proc()

func find_possible_targets(arena_scene, possible_targets):
	for opponent in arena_scene.p1cards:
		if opponent.card_name != "ghost" and opponent.hp > 0:
			possible_targets.append(opponent)
	for opponent in arena_scene.p2cards:
		if opponent.card_name != "ghost" and opponent.hp > 0:
			possible_targets.append(opponent)
	for opponent in arena_scene.p3cards:
		if opponent.card_name != "ghost" and opponent.hp > 0:
			possible_targets.append(opponent)
	for opponent in arena_scene.p4cards:
		if opponent.card_name != "ghost" and opponent.hp > 0:
			possible_targets.append(opponent)
