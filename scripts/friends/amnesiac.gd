extends Card


func start_battle():
	if not blocked_ability:
		var highest_attack = 0
		proc()
		match team_number:
			1:
				for friend in Manager.teamP1:
					if friend != null:
						if friend.attack > highest_attack:
							highest_attack = friend.attack
			2:
				for friend in Manager.teamP2:
					if friend != null:
						if friend.attack > highest_attack:
							highest_attack = friend.attack
			3:
				for friend in Manager.teamP3:
					if friend != null:
						if friend.attack > highest_attack:
							highest_attack = friend.attack
			4:
				for friend in Manager.teamP4:
					if friend != null:
						if friend.attack > highest_attack:
							highest_attack = friend.attack
		attack = highest_attack
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, "")
		setStatText()
		await proc()

func friend_dies(_dead_friend_catagory):
	if not blocked_ability and upgraded:
		attack += 2
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, "2")
		setStatText()
		await proc()
