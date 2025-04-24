extends Card


func end_turn():
	if not blocked_ability:
		Manager.update_friends()
		var target_friend = null
		var slot_position
		var search_position
		slot_position = Manager.friends.find(self)
		search_position = slot_position + 1
		while search_position < 6:
			if Manager.friends[search_position] == null:
				search_position += 1
			else:
				target_friend = Manager.friends[search_position]
				break
		if target_friend != null:
			proc()
			Manager.move_symbol(global_position, target_friend.global_position, blue_icon, "")
			await get_tree().create_timer(0.35).timeout
			target_friend.colour = colours.BLUE
			target_friend.setColour()
			await proc()

func start_battle():
	if not blocked_ability:
		var attack_to_gain = 0
		proc()
		match team_number:
			1:
				for friend in Manager.teamP1:
					if friend != null:
						if friend.colour == colours.BLUE:
							attack_to_gain += 1
			2:
				for friend in Manager.teamP2:
					if friend != null:
						if friend.colour == colours.BLUE:
							attack_to_gain += 1
			3:
				for friend in Manager.teamP3:
					if friend != null:
						if friend.colour == colours.BLUE:
							attack_to_gain += 1
			4:
				for friend in Manager.teamP4:
					if friend != null:
						if friend.colour == colours.BLUE:
							attack_to_gain += 1
		if upgraded:
			attack_to_gain *= 3
		if attack_to_gain > 0:
			attack += attack_to_gain
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_to_gain))
			await proc()
