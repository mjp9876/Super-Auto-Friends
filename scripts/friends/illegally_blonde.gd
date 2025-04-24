extends Card


func end_turn():
	if not blocked_ability:
		Manager.update_friends()
		var bonus_multiplier = 0
		for friend in Manager.friends:
			if friend != null and friend.catagory == catagories.SONGS_MUSICIANS_INSTRUMENTS:
				bonus_multiplier += 1
		if bonus_multiplier > 0:
			proc()
			hp += 5 * bonus_multiplier
			Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(5 * bonus_multiplier))
			if upgraded:
				await get_tree().create_timer(0.2).timeout
				attack += bonus_multiplier
				Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(bonus_multiplier))
			setStatText()
			await proc()
