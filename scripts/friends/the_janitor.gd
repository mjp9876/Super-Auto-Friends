extends Card


func reroll():
	if not blocked_ability:
		var attack_to_gain = 1
		if upgraded:
			attack_to_gain = shopScene.reroll_cost - 1
		if attack_to_gain > 0:
			attack += attack_to_gain
			reduce_attack += attack_to_gain
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_to_gain))
			setStatText()
			await proc()
