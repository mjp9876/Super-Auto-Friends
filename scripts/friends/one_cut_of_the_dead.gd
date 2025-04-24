extends Card

func hurt(_attacker):
	if not blocked_ability:
		var attack_to_gain = 1
		if upgraded:
			attack_to_gain = 2
		attack += attack_to_gain
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_to_gain))
		setStatText()
		await quick_proc()
