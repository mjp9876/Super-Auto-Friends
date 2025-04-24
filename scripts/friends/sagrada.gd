extends Card


func start_turn():
	if not blocked_ability:
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

func end_turn():
	if not blocked_ability:
		var found_colours = [0, 0, 0, 0]
		var attack_to_gain = 2
		if upgraded:
			attack_to_gain = 4
		Manager.update_friends()
		for friend in Manager.friends:
			if friend != null:
				found_colours[friend.colour] += 1
		if 0 not in found_colours:
			attack += attack_to_gain
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_to_gain))
			setStatText()
			await proc()
