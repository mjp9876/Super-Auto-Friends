extends Card


func end_turn():
	if not blocked_ability and Manager.playerNum in Manager.previous_round_winner:
		Manager.update_friends()
		var attack_to_give = 2
		var target_friend = null
		var search_position = 5
		if upgraded:
			attack_to_give = 5
		while search_position >= 0:
			if Manager.friends[search_position] == null:
				search_position -= 1
			else:
				target_friend = Manager.friends[search_position]
		target_friend.attack += attack_to_give
		Manager.move_symbol(global_position, target_friend.global_position, most_attack_target_texture, str(attack_to_give))
		target_friend.setStatText()
		await proc()
