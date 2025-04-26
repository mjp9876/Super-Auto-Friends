extends Card




func start_turn():
	if not blocked_ability:
		if not upgraded:
			attack = rng.randi_range(1,cost)
			Manager.move_symbol(global_position, global_position, attack_icon, str(attack))
			setStatText()
		elif upgraded:
			attack = rng.randi_range(1,cost)
			x = rng.randi_range(1,cost)
			Manager.move_symbol(global_position, global_position, attack_icon, str(attack))
			Manager.move_symbol(global_position, global_position, x_icon, str(x))
			setStatText()
		await proc()
