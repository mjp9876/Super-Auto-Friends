extends Card


func end_turn():
	if not blocked_ability and Manager.playerNum in Manager.previous_round_winner:
		Manager.update_friends()
		var hp_to_give = 10
		var target_friend = null
		var search_position = 5
		if upgraded:
			hp_to_give = 25
		while search_position >= 0:
			if Manager.friends[search_position] == null:
				search_position -= 1
			else:
				target_friend = Manager.friends[search_position]
		target_friend.hp += hp_to_give
		Manager.move_symbol(global_position, target_friend.global_position, most_hp_target_texture, str(hp_to_give))
		target_friend.setStatText()
		await proc()

