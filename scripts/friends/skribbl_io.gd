extends Card


func card_specific_rng():
	colour_order = []
	this_colour = colours.CHANGE
	colour_order2 = []
	this_colour2 = colours.CHANGE
	target_order = []
	this_target = targets.values().pick_random()
	for i in range(18):
		while this_colour2 == colours.CHANGE or this_colour2 == colours.ITEM:
			this_colour2 = colours.values().pick_random()
		colour_order2.append(this_colour2)
		this_colour2 = colours.CHANGE
		this_target = targets.values().pick_random()
		target_order.append(this_target)
	for i in range((hp + 3) * (x + 3)):
		while this_colour == colours.CHANGE or this_colour == colours.ITEM:
			this_colour = colours.values().pick_random()
		colour_order.append(this_colour)
		this_colour = colours.CHANGE

func start_turn():
	if not blocked_ability and not upgraded:
		var random_colour
		var random_colour_icon
		random_colour = colours.values().pick_random()
		while random_colour == colour or random_colour == colours.ITEM or random_colour == colours.CHANGE:
			random_colour = colours.values().pick_random()
		random_colour_icon = find_colour_icon(random_colour)
		colour = random_colour
		Manager.move_symbol(global_position, global_position, random_colour_icon, "")
		setColour()
		await proc()
	elif not blocked_ability and upgraded:
		Manager.update_friends()
		var target_friend = null
		var slot_position
		var search_position
		slot_position = Manager.friends.find(self)
		search_position = slot_position - 1
		while search_position >= 0:
			if Manager.friends[search_position] == null:
				search_position -= 1
			else:
				target_friend = Manager.friends[search_position]
				break
		if target_friend != null:
			proc()
			Manager.move_symbol(target_friend.global_position, global_position, find_colour_icon(target_friend.colour), "")
			await get_tree().create_timer(0.35).timeout
			colour = target_friend.colour
			setColour()
			await proc()

func kill(dead_team, dead_team_index):
	if not blocked_ability:
		match dead_team:
			1:
				if Manager.saved_team1[dead_team_index] != null:
					while Manager.saved_team1[dead_team_index]["colour"] == colour_order[0]:
						colour_order.pop_front()
					Manager.saved_team1[dead_team_index]["colour"] = colour_order[0]
			2:
				if Manager.saved_team2[dead_team_index] != null:
					while Manager.saved_team2[dead_team_index]["colour"] == colour_order[0]:
						colour_order.pop_front()
					Manager.saved_team2[dead_team_index]["colour"] = colour_order[0]
			3:
				if Manager.saved_team3[dead_team_index] != null:
					while Manager.saved_team3[dead_team_index]["colour"] == colour_order[0]:
						colour_order.pop_front()
					Manager.saved_team3[dead_team_index]["colour"] = colour_order[0]
			4:
				if Manager.saved_team4[dead_team_index] != null:
					while Manager.saved_team4[dead_team_index]["colour"] == colour_order[0]:
						colour_order.pop_front()
					Manager.saved_team4[dead_team_index]["colour"] = colour_order[0]
		colour_order.pop_front()

func start_battle():
	if not blocked_ability and upgraded:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var cards_to_buff = []
		var colour_index = 0
		var target_index = 0
		find_possible_targets(arena_scene, cards_to_buff)
		for character in cards_to_buff:
			proc()
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
	character.colour = colour_order2[index]
	Manager.move_symbol(global_position, character.global_position, find_colour_icon(colour_order2[index]), "")
	await get_tree().create_timer(0.1).timeout
	character.setColour()

func set_card_target(character, index):
	character.target = target_order[index]
	Manager.move_symbol(global_position, character.global_position, find_target_icon(target_order[index]), "")
	await get_tree().create_timer(0.1).timeout
	character.setTarget()
