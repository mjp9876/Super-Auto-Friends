extends Card


func start_battle():
	if not blocked_ability and team_number not in Manager.previous_round_winner:
		var attack_to_gain = 4
		if upgraded:
			attack_to_gain = 8
		attack += attack_to_gain
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_to_gain))
		setStatText()
		await proc()
