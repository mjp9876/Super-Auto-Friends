extends Card


func end_turn():
	if not blocked_ability:
		var hp_to_give = 4
		if upgraded:
			hp_to_give = 6
		Manager.update_friends()
		for friend in Manager.friends:
			if friend != null:
				proc()
				friend.hp += hp_to_give
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, str(hp_to_give))
				await get_tree().create_timer(0.2).timeout
				friend.setStatText()
		for friend in Manager.friends:
			if upgraded and friend != null and friend.catagory == catagories.SIBLINGS and friend != self:
				proc()
				friend.hp += hp_to_give
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, str(hp_to_give))
				await get_tree().create_timer(0.2).timeout
				friend.setStatText()
		await proc()
