extends Card


func kill(_dead_card_team, _dead_card_starting_position_i_think):
	if not blocked_ability and hp > 0:
		var hp_gain = 26
		if upgraded:
			hp_gain = 44
		hp += hp_gain
		Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(hp_gain))
		await proc()
