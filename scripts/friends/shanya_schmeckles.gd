extends Card


func card_specific_rng():
	options = ["hp", "attack", "die"]
	choice = options.pick_random()

func start_battle():
	if not blocked_ability:
		var hp_to_gain = 5
		var attack_to_gain = 1
		if upgraded:
			hp_to_gain = 7
			attack_to_gain = 4
		match choice:
			"hp":
				hp += hp_to_gain
				Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(hp_to_gain))
				setStatText()
			"attack":
				attack += attack_to_gain
				Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_to_gain))
				setStatText()
			"die":
				hp = 0
				Manager.move_symbol(global_position, global_position, attack_icon, str(hp))
				setStatText()
		await proc()
