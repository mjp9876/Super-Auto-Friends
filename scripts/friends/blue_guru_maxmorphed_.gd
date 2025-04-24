extends Card

func friend_dies(_dead_friend_catagory):
	if not blocked_ability and hp > 0:
		proc()
		var hp_increase = 4
		if upgraded:
			hp_increase = 10
		hp += hp_increase
		attack += 1
		Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(hp_increase))
		await get_tree().create_timer(0.2).timeout
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, "1")
		setStatText()
		await proc()
