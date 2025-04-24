extends Card


func start_battle():
	if not blocked_ability and active and hp > 0:
		var hp_gain = 12
		var attack_gain = 2
		if upgraded:
			hp_gain = 16
			attack_gain = 3
		proc()
		hp += hp_gain
		Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(hp_gain))
		await get_tree().create_timer(0.2).timeout
		attack += attack_gain
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_gain))
		if upgraded:
			await get_tree().create_timer(0.2).timeout
			x += 1
			this_x = x
			Manager.move_symbol(global_position, global_position, x_icon, "")
		await proc()
