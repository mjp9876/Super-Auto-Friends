extends Card

func card_specific_rng():
	choices = []
	options = ["hp", "attack", "x"]
	choices = options.duplicate()
	choices.shuffle()

func start_turn():
	if not blocked_ability:
		var new_target
		new_target = targets.values().pick_random()
		target = new_target
		Manager.move_symbol(global_position, global_position, find_target_icon(new_target), "")
		setTarget()
		await proc()

func start_battle():
	if not blocked_ability:
		var attack_to_give = 8
		if not upgraded and choices[0] == "x":
			choices.pop_front()
		if upgraded:
			attack_to_give = 16
		match choices[0]:
			"hp":
				if hp > 0:
					hp = max(1, hp - 10)
				Manager.move_symbol(global_position, global_position, least_hp_target_texture, "10")
			"attack":
				attack += attack_to_give
				Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_to_give))
			"x":
				x += 5
				this_x = x
				Manager.move_symbol(global_position, global_position, x_icon, "")
		setStatText()
		await proc()
