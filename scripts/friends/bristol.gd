extends Card


func start_turn():
	if not blocked_ability:
		var money_to_gain = 4
		if upgraded:
			money_to_gain = 6
		Manager.money += money_to_gain
		Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, str(money_to_gain))
		shopScene.updateText()
		await proc()

