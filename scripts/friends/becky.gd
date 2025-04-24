extends Card


func start_turn():
	if not blocked_ability:
		proc()
		x += 1
		Manager.move_symbol(global_position, global_position, x_icon, "")
		setStatText()
		await proc()

func start_battle():
	if not blocked_ability and upgraded:
		proc()
		x += 3
		this_x = x
		Manager.move_symbol(global_position, global_position, x_icon, "3")
		setStatText()
		await proc()
