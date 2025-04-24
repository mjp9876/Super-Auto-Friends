extends Card



func friend_uses_item(target_friend):
	if not blocked_ability and target_friend != null:
		var start_position = global_position
		var bonus = 1
		if upgraded:
			bonus = 2
		target_friend.x += bonus
		target_friend.reduceX += bonus
		Manager.move_symbol(start_position, target_friend.global_position, x_icon, str(bonus))
		target_friend.setStatText()
		await proc()
