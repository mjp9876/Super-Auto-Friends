extends Card


func start_turn():
	if not blocked_ability:
		var x_cap = 1
		if upgraded:
			x_cap = 3
		if x > x_cap:
			x -= 1
			Manager.move_symbol(global_position, global_position, x_icon, "-")
			setStatText()
			await proc()

func end_turn():
	if not blocked_ability and rng.randf() < 0.45:
		var x_to_gain = 1
		if upgraded:
			x_to_gain = 2
		x += x_to_gain
		Manager.move_symbol(global_position, global_position, x_icon, "")
		setStatText()
		await proc()
