extends Card


func end_turn():
	if not blocked_ability:
		var friend_ahead = find_friend_ahead()
		var red_cards_in_team = find_red_cards()
		var non_red_cards_in_team = find_non_red_cards()
		if not upgraded:
			if friend_ahead != null:
				friend_ahead.hp += red_cards_in_team.size()
				Manager.move_symbol(global_position, friend_ahead.global_position, most_hp_target_texture, str(red_cards_in_team.size()))
				friend_ahead.setStatText()
		elif upgraded and non_red_cards_in_team > 0:
			for friend in red_cards_in_team:
				friend.hp += non_red_cards_in_team
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, str(non_red_cards_in_team))
				friend.setStatText()
		await proc()

func find_red_cards():
	var red_cards = []
	Manager.update_friends()
	for friend in Manager.friends:
		if friend != null and friend.colour == colours.RED:
			red_cards.append(friend)
	return red_cards

func find_non_red_cards():
	var non_red_cards = 0
	Manager.update_friends()
	for friend in Manager.friends:
		if friend != null and friend.colour != colours.RED:
			non_red_cards += 1
	return non_red_cards

func find_friend_ahead():
	var slot_position = Manager.friends.find(self)
	var search_position = slot_position + 1
	var target_friend
	while search_position < 6:
		if Manager.friends[search_position] == null:
			search_position += 1
		else:
			target_friend = Manager.friends[search_position]
			break
	return target_friend
