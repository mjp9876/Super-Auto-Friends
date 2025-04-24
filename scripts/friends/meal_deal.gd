extends Card


func end_turn():
	if not blocked_ability:
		var need_to_proc = false
		Manager.update_friends()
		for friend in Manager.friends:
			if friend != null and (friend.colour == colours.BLUE or (friend.colour == colours.GREEN and upgraded)):
				proc()
				need_to_proc = true
				friend.hp += 3
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "3")
				await get_tree().create_timer(0.2).timeout
				friend.setStatText()
		if need_to_proc:
			await proc()
