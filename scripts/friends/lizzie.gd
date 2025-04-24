extends Card

func before_attack():
	if not blocked_ability:
		var attack_to_gain = 1
		if upgraded:
			attack_to_gain = 2
		attack += attack_to_gain
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_to_gain))
		setStatText()
		await quick_proc()

func hurt(_attacker):
	if not blocked_ability and attack > 1:
		var attack_to_lose = 2
		if upgraded:
			attack_to_lose = 1
		attack = max(1, attack - attack_to_lose)
		Manager.move_symbol(global_position, global_position, least_attack_target_texture, str(attack_to_lose))
		setStatText()
		await quick_proc()
