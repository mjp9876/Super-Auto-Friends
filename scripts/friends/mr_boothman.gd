extends Card


func start_turn():
	if not blocked_ability:
		var money_multiplier = 1
		var sports_in_team = 0
		if upgraded:
			money_multiplier = 2
		Manager.update_friends()
		for friend in Manager.friends:
			if friend != null and friend.catagory == catagories.SPORT_AND_EXERCISE:
				sports_in_team += 1
		if sports_in_team > 0:
			Manager.money += money_multiplier * sports_in_team
			shopScene.updateText()
			await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, str(money_multiplier * sports_in_team))
			await proc()
