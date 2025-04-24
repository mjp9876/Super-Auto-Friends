extends Card


func start_turn():
	if not blocked_ability:
		var moneymakers_in_team = 0
		Manager.update_friends()
		for friend in Manager.friends:
			if friend != null and (friend.colour == colours.RED or (friend.colour == colours.YELLOW and upgraded)):
				moneymakers_in_team += 1
		if moneymakers_in_team > 0:
			Manager.money += moneymakers_in_team
			shopScene.updateText()
			await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, str(moneymakers_in_team))
			await proc()
