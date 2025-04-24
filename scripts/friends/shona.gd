extends Card


func end_turn():
	if not blocked_ability:
		Manager.update_friends()
		var hp_to_give = 5
		var attack_to_give = 1
		if upgraded:
			hp_to_give = 10
			attack_to_give = 2
		proc()
		Manager.friends[0].hp += hp_to_give
		Manager.move_symbol(global_position, Manager.friends[0].global_position, most_hp_target_texture, str(hp_to_give))
		await get_tree().create_timer(0.2).timeout
		Manager.friends[0].attack += attack_to_give
		Manager.move_symbol(global_position, Manager.friends[0].global_position, most_attack_target_texture, str(attack_to_give))
		Manager.friends[0].setStatText()
		await proc()
