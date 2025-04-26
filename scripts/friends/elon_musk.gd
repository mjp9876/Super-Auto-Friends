extends Card


# Called when the node enters the scene tree for the first time.
func end_turn():

	if not blocked_ability:
		if not upgraded:
			for friend in Manager.friends:
				if friend != null:
					friend.cost += friend.cost / 5
					Manager.move_symbol(global_position, friend.global_position, coin_icon, "+" + str(friend.cost / 5))
					friend.setStatText()
		else:
			for friend in Manager.friends: 
				if friend != null:
					friend.cost += friend.cost * 0.3
					Manager.move_symbol(global_position, friend.global_position, coin_icon, "+" + str(int(friend.cost * 0.3)))
					friend.setStatText()
		await proc()
