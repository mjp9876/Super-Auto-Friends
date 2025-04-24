extends Card


func after_attack():
	if not blocked_ability:
		var attack_to_lose = 14
		if upgraded:
			attack_to_lose = 3
		attack = max(1, attack - attack_to_lose)
		Manager.move_symbol(global_position, global_position, least_attack_target_texture, str(attack_to_lose))
		setStatText()
		await proc()
