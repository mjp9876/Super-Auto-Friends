extends Card


func buy():
	if not blocked_ability:
		choice = str(rng.randi_range(0, 4))

func start_battle():
	print(choice)
	if not blocked_ability and str(starting_fighting_slot) == choice:
		var hp_to_gain = 40
		var attack_to_gain = 8
		proc()
		if upgraded:
			hp_to_gain = 60
			attack_to_gain = 12
		colour = colours.GREEN
		Manager.move_symbol(global_position, global_position, green_icon, "")
		await get_tree().create_timer(0.2).timeout
		setColour()
		hp += hp_to_gain
		Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(hp_to_gain))
		await get_tree().create_timer(0.2).timeout
		attack += attack_to_gain
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_to_gain))
		if upgraded:
			await get_tree().create_timer(0.2).timeout
			x += 2
			this_x = x
			Manager.move_symbol(global_position, global_position, x_icon, "")
		await proc()

func start_turn():
	if not blocked_ability and Manager.playerNum in Manager.previous_round_winner:
		choice = str(rng.randi_range(0, 4))
