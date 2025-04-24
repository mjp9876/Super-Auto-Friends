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
			Manager.move_symbol(global_position, target_friend.global_position, red_icon, "")
			await get_tree().create_timer(0.35).timeout
			target_friend.colour = colours.RED
			target_friend.setColour()
			await proc()

func start_battle():
	if not blocked_ability:
		var hp_to_gain = 0
		var hp_increase = 3
		if upgraded:
			hp_increase = 7
		proc()
		match team_number:
			1:
				for friend in Manager.teamP1:
					if friend != null:
						if friend.colour == colours.RED:
							hp_to_gain += hp_increase
			2:
				for friend in Manager.teamP2:
					if friend != null:
						if friend.colour == colours.RED:
							hp_to_gain += hp_increase
			3:
				for friend in Manager.teamP3:
					if friend != null:
						if friend.colour == colours.RED:
							hp_to_gain += hp_increase
			4:
				for friend in Manager.teamP4:
					if friend != null:
						if friend.colour == colours.RED:
							hp_to_gain += hp_increase
		if hp_to_gain > 0:
			hp += hp_to_gain
			Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(hp_to_gain))
			await proc()
