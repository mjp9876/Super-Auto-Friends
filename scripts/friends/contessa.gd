extends Card


func friend_ahead_attacks(friend_ahead):
	if not blocked_ability:
		var hp_threshold = 8
		if upgraded:
			hp_threshold = 18
		if friend_ahead.hp <= hp_threshold and friend_ahead.hp > 0:
			friend_ahead.hp += 8
			Manager.move_symbol(global_position, friend_ahead.global_position, most_hp_target_texture, "8")
			await proc()
