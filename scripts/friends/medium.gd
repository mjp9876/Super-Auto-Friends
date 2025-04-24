extends Card


func friend_dies(dead_catagory):
	if not blocked_ability and dead_catagory == catagories.TOWN_OF_SALEM:
		var hp_to_gain = 8
		if upgraded:
			hp_to_gain = 18
		hp += hp_to_gain
		Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(hp_to_gain))
		setStatText()
		await proc()
