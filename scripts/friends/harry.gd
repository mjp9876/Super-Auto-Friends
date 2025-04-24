extends Card


func end_turn():
	if not blocked_ability and Manager.playerNum not in Manager.previous_round_winner:
		hp += 1
		Manager.move_symbol(global_position, global_position, most_hp_target_texture, "1")
		setStatText()
		await proc()
