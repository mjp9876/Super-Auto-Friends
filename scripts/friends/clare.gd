extends Card


func end_turn():
	if not blocked_ability:
		Manager.update_friends()
		var target_friend = null
		if upgraded:
			while target_friend == self or target_friend == null or target_friend == Manager.friends[0]:
				target_friend = Manager.friends.pick_random()
		proc()
		Manager.friends[0].x += 1
		Manager.move_symbol(global_position, Manager.friends[0].global_position, x_icon, "")
		Manager.friends[0].setStatText()
		if target_friend != null:
			await get_tree().create_timer(0.2).timeout
			target_friend.x += 1
			Manager.move_symbol(global_position, target_friend.global_position, x_icon, "")
			target_friend.setStatText()
		await proc()
