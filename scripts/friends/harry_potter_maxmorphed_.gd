extends Card


func start_battle():
	if not blocked_ability:
		var highest_x = 0
		proc()
		if upgraded:
			for friend in Manager.teamP1:
				if friend != null:
					if friend.x > highest_x:
						highest_x = friend.x
			for friend in Manager.teamP2:
				if friend != null:
					if friend.x > highest_x:
						highest_x = friend.x
			for friend in Manager.teamP3:
				if friend != null:
					if friend.x > highest_x:
						highest_x = friend.x
			for friend in Manager.teamP4:
				if friend != null:
					if friend.x > highest_x:
						highest_x = friend.x
		else:
			match team_number:
				1:
					for friend in Manager.teamP1:
						if friend != null:
							if friend.x > highest_x:
								highest_x = friend.x
				2:
					for friend in Manager.teamP2:
						if friend != null:
							if friend.x > highest_x:
								highest_x = friend.x
				3:
					for friend in Manager.teamP3:
						if friend != null:
							if friend.x > highest_x:
								highest_x = friend.x
				4:
					for friend in Manager.teamP4:
						if friend != null:
							if friend.x > highest_x:
								highest_x = friend.x
		var multiplier = 0.67
		if upgraded:
			multiplier = 0.8
		highest_x = int(highest_x * multiplier)
		x = highest_x
		this_x = x
		Manager.move_symbol(global_position, global_position, x_icon, "")
		setStatText()
		await proc()
