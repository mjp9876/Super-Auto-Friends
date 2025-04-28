extends Card


func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var cards_to_buff = []
		if upgraded:
			find_possible_targets(arena_scene, cards_to_buff)
		else:
			find_team_mates(arena_scene, cards_to_buff)
		for character in cards_to_buff:
			proc()
			await set_card_target(character)
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

func find_team_mates(arena_scene, possible_targets):
	if team_number == 1:
		for opponent in arena_scene.p1cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)
	if team_number == 2:
		for opponent in arena_scene.p2cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)
	if team_number == 3:
		for opponent in arena_scene.p3cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)
	if team_number == 4:
		for opponent in arena_scene.p4cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)

func set_card_target(character):
	character.target = targets.MOST_WINS
	Manager.move_symbol(global_position, character.global_position, most_wins_target_texture, "")
	await get_tree().create_timer(0.1).timeout
	character.setTarget()
