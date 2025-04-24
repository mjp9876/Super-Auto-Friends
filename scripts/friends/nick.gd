extends Card


func end_turn():
	if not blocked_ability:
		Manager.update_friends()
		var hp_to_give = 7
		if upgraded:
			hp_to_give = 14
		Manager.friends[0].hp += hp_to_give
		Manager.move_symbol(global_position, Manager.friends[0].global_position, most_hp_target_texture, str(hp_to_give))
		Manager.friends[0].setStatText()
		await proc()
