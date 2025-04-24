extends Card


func card_specific_rng():
	colour_order = []
	this_colour = colours.CHANGE
	target_order = []
	options = ["colour", "target"]
	for i in range(18):
		while this_colour == colours.CHANGE or this_colour == colours.ITEM:
			this_colour = colours.values().pick_random()
		colour_order.append(this_colour)
		this_colour = colours.CHANGE
		this_target = targets.values().pick_random()
		target_order.append(this_target)
	choice = options.pick_random()

func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var cards_to_buff = []
		var colour_index = 0
		var target_index = 0
		find_possible_targets(arena_scene, cards_to_buff)
		for character in cards_to_buff:
			proc()
			if not upgraded:
				match choice:
					"colour":
						await set_card_colour(character, colour_index)
					"target":
						await set_card_target(character, target_index)
			else:
				await set_card_colour(character, colour_index)
				await set_card_target(character, target_index)
			colour_index += 1
			target_index += 1
		await proc()

func find_possible_targets(arena_scene, possible_targets):
	if team_number != 1:
		for opponent in arena_scene.p1cards:
			if opponent.card_name != "ghost" and opponent.hp > 0 and opponent != self:
				possible_targets.append(opponent)
	if team_number != 2:
		for opponent in arena_scene.p2cards:
			if opponent.card_name != "ghost" and opponent.hp > 0 and opponent != self:
				possible_targets.append(opponent)
	if team_number != 3:
		for opponent in arena_scene.p3cards:
			if opponent.card_name != "ghost" and opponent.hp > 0 and opponent != self:
				possible_targets.append(opponent)
	if team_number != 4:
		for opponent in arena_scene.p4cards:
			if opponent.card_name != "ghost" and opponent.hp > 0 and opponent != self:
				possible_targets.append(opponent)

func set_card_colour(character, index):
	character.colour = colour_order[index]
	Manager.move_symbol(global_position, character.global_position, find_colour_icon(colour_order[index]), "")
	await get_tree().create_timer(0.1).timeout
	character.setColour()

func set_card_target(character, index):
	character.target = target_order[index]
	Manager.move_symbol(global_position, character.global_position, find_target_icon(target_order[index]), "")
	await get_tree().create_timer(0.1).timeout
	character.setTarget()
