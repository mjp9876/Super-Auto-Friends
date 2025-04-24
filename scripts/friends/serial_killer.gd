extends Card


func end_turn():
	if not blocked_ability:
		var attack_multiplier = 2
		var empty_spaces = 0
		if upgraded:
			attack_multiplier = 4
		Manager.update_friends()
		empty_spaces = Manager.friends.count(null)
		if empty_spaces > 0:
			attack += empty_spaces * attack_multiplier
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(empty_spaces * attack_multiplier))
			setStatText()
			await proc()
