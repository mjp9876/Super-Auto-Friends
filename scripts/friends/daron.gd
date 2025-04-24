extends Card


func end_turn():
	if not blocked_ability:
		Manager.update_friends()
		var attack_to_give = 2
		if upgraded:
			attack_to_give = 3
		Manager.friends[0].attack += attack_to_give
		Manager.move_symbol(global_position, Manager.friends[0].global_position, most_attack_target_texture, str(attack_to_give))
		Manager.friends[0].setStatText()
		await proc()
