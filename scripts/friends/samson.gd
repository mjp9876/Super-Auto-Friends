extends Card


func before_attack():
	if not blocked_ability and upgraded:
		proc()
		hp += 12
		Manager.move_symbol(global_position, global_position, most_hp_target_texture, "12")
		await get_tree().create_timer(0.2).timeout
		attack += 3
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, "3")
		await proc()

func after_attack():
	if not blocked_ability and not upgraded and hp > 0:
		proc()
		hp += 8
		Manager.move_symbol(global_position, global_position, most_hp_target_texture, "8")
		await get_tree().create_timer(0.2).timeout
		attack += 2
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, "2")
		await proc()
