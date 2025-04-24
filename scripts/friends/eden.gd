extends Card


func card_specific_rng():
	choices = []
	options = ["hp", "attack", "x"]
	choices = options.duplicate()
	choices.shuffle()

func buy():
	var buy_buffs = ["5hp", "15hp", "1attack", "4attack", "2x"]
	match buy_buffs.pick_random():
		"5hp":
			hp += 15
			Manager.move_symbol(global_position, global_position, most_hp_target_texture, "5")
		"15hp":
			hp += 45
			Manager.move_symbol(global_position, global_position, most_hp_target_texture, "45")
		"1attack":
			attack += 1
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, "1")
		"4attack":
			attack += 8
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, "8")
		"2x":
			x += 3
			Manager.move_symbol(global_position, global_position, x_icon, "")
	setStatText()
	await proc()

func start_battle():
	if not blocked_ability and upgraded:
		match choices[0]:
			"hp":
				hp += 20
				Manager.move_symbol(global_position, global_position, most_hp_target_texture, "10")
			"attack":
				attack += 3
				Manager.move_symbol(global_position, global_position, most_attack_target_texture, "3")
			"x":
				x += 2
				this_x = x
				Manager.move_symbol(global_position, global_position, x_icon, "")
		setStatText()
		await proc()
