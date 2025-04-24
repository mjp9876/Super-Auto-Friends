extends Card

func end_turn():
	if not blocked_ability and upgraded:
		Manager.update_friends()
		var target_friend = null
		var slot_position
		var search_position
		slot_position = Manager.friends.find(self)
		search_position = slot_position + 1
		while search_position < 6:
			if Manager.friends[search_position] == null:
				search_position += 1
			else:
				target_friend = Manager.friends[search_position]
				break
		if target_friend != null:
			proc()
			Manager.move_symbol(global_position, target_friend.global_position, red_icon, "")
			await get_tree().create_timer(0.35).timeout
			target_friend.colour = colours.RED
			target_friend.setColour()
			await proc()

func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var x_to_get = 0
		x_to_get = find_red_team_mates(arena_scene)
		if upgraded and colour == colours.RED:
			x_to_get += 1
		if x_to_get >= 1:
			x += x_to_get
			this_x = x
			Manager.move_symbol(global_position, global_position, x_icon, "")
			setStatText()
			await proc()

func find_red_team_mates(arena_scene):
	var red_team_mates_found = 0
	match team_number:
		1:
			for opponent in arena_scene.p1cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.RED and opponent != self:
					red_team_mates_found += 1
		2:
			for opponent in arena_scene.p2cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.RED and opponent != self:
					red_team_mates_found += 1
		3:
			for opponent in arena_scene.p3cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.RED and opponent != self:
					red_team_mates_found += 1
		4:
			for opponent in arena_scene.p4cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.RED and opponent != self:
					red_team_mates_found += 1
	return red_team_mates_found
