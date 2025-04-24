extends Card


func end_turn():
	if not blocked_ability:
		var options = ["3coin", "5hp", "-4hp", "1attack", "-1attack", "colour", "target"]
		var random_target
		var random_colour
		var random_target_icon
		var random_colour_icon
		if upgraded:
			options.erase("-4hp")
			options.erase("-1attack")
			options.erase("colour")
		options.shuffle()
		match options[0]:
			"3coin":
				Manager.money += 3
				shopScene.updateText()
				await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "3")
			"5hp":
				hp += 5
				Manager.move_symbol(global_position, global_position, most_hp_target_texture, "5")
			"-4hp":
				hp = max(hp - 4, 1)
				Manager.move_symbol(global_position, global_position, least_hp_target_texture, "4")
			"1attack":
				attack += 1
				Manager.move_symbol(global_position, global_position, most_attack_target_texture, "1")
			"-1attack":
				attack = max(attack - 1, 1)
				Manager.move_symbol(global_position, global_position, least_attack_target_texture, "1")
			"target":
				random_target = targets.values().pick_random()
				while random_target == target:
					random_target = targets.values().pick_random()
				random_target_icon = find_target_icon(random_target)
				target = random_target
				Manager.move_symbol(global_position, global_position, random_target_icon, "")
				setTarget()
			"colour":
				random_colour = colours.values().pick_random()
				while random_colour == colour or random_colour == colours.ITEM or random_colour == colours.CHANGE:
					random_colour = colours.values().pick_random()
				random_colour_icon = find_colour_icon(random_colour)
				colour = random_colour
				Manager.move_symbol(global_position, global_position, random_colour_icon, "")
				setColour()
		setStatText()
		await proc()
