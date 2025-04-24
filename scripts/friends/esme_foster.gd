extends Card


func friend_ahead_attacks(_friend):
	if not blocked_ability:
		var attack_to_gain = 2
		if upgraded:
			attack_to_gain = 4
		attack += attack_to_gain
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_to_gain))
		setStatText()
		await proc()
