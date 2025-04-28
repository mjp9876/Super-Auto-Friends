extends Card


func friend_summoned(_new_friend):
	if not blocked_ability and inBattle:
		await buff_all_yellow_cards()

func enemy_summoned(_enemy):
	if not blocked_ability and inBattle:
		await buff_all_yellow_cards()

func buff_all_yellow_cards():
	var arena_scene = get_tree().get_first_node_in_group("arena")
	var cards_to_buff = []
	var hp_to_give = 15
	if upgraded:
		hp_to_give = 30
	find_possible_targets(arena_scene, cards_to_buff)
	for character in cards_to_buff:
		proc()
		character.hp += hp_to_give
		Manager.move_symbol(global_position, character.global_position, most_hp_target_texture, str(hp_to_give))
		await get_tree().create_timer(0.1).timeout
		character.setStatText()
	await proc()

func find_possible_targets(arena_scene, possible_targets):
	for opponent in arena_scene.p1cards:
		if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.YELLOW:
			possible_targets.append(opponent)
	for opponent in arena_scene.p2cards:
		if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.YELLOW:
			possible_targets.append(opponent)
	for opponent in arena_scene.p3cards:
		if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.YELLOW:
			possible_targets.append(opponent)
	for opponent in arena_scene.p4cards:
		if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.YELLOW:
			possible_targets.append(opponent)
