extends Card

func card_specific_rng():
	options = ["hp", "attack"]
	options.shuffle()

func start_battle():
	if not blocked_ability:
		match options[0]:
			"hp":
				hp += 5
				Manager.move_symbol(global_position, global_position, most_hp_target_texture, "5")
			"attack":
				attack += 1
				Manager.move_symbol(global_position, global_position, most_attack_target_texture, "1")
		setStatText()
		await proc()
