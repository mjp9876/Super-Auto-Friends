extends Card


func use_item():
	if not blocked_ability:
		attack += 1
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, "1")
		setStatText()
		await proc()

func friend_uses_item(_friend):
	if not blocked_ability and upgraded:
		hp += 2
		Manager.move_symbol(global_position, global_position, most_hp_target_texture, "2")
		setStatText()
		await quick_proc()
