extends Card


func after_attack():
	if not blocked_ability and not upgraded and hp > 0:
		x += 1
		this_x = x
		Manager.move_symbol(global_position, global_position, x_icon, "")
		setStatText()
		await proc()

func before_attack():
	if not blocked_ability and upgraded:
		x += 1
		this_x = x
		Manager.move_symbol(global_position, global_position, x_icon, "")
		setStatText()
		await proc()
