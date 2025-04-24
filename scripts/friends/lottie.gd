extends Card


func end_turn():
	if not blocked_ability:
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
			Manager.move_symbol(global_position, target_friend.global_position, green_icon, "")
			await get_tree().create_timer(0.35).timeout
			target_friend.colour = colours.GREEN
			target_friend.setColour()
			await proc()

func hurt(_attacker):
	if not blocked_ability and upgraded and hp > 0:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var hp_to_gain = 0
		hp_to_gain = find_green_team_mates(arena_scene)
		if hp_to_gain >= 1:
			hp += hp_to_gain
			Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(hp_to_gain))
			setStatText()
			await quick_proc()

func start_battle():
	if not blocked_ability and not upgraded:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var hp_to_gain = 0
		hp_to_gain = find_green_team_mates(arena_scene) * 3
		if hp_to_gain >= 1 and hp > 0:
			hp += hp_to_gain
			Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(hp_to_gain))
			setStatText()
			await quick_proc()

func find_green_team_mates(arena_scene):
	var green_team_mates_found = 0
	match team_number:
		1:
			for opponent in arena_scene.p1cards:
				if opponent.card_name != "ghost" and opponent.colour == colours.GREEN and opponent != self:
					green_team_mates_found += 1
		2:
			for opponent in arena_scene.p2cards:
				if opponent.card_name != "ghost" and opponent.colour == colours.GREEN and opponent != self:
					green_team_mates_found += 1
		3:
			for opponent in arena_scene.p3cards:
				if opponent.card_name != "ghost" and opponent.colour == colours.GREEN and opponent != self:
					green_team_mates_found += 1
		4:
			for opponent in arena_scene.p4cards:
				if opponent.card_name != "ghost" and opponent.colour == colours.GREEN and opponent != self:
					green_team_mates_found += 1
	return green_team_mates_found
