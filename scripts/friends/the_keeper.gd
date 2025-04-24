extends Card


func start_turn():
	if not blocked_ability:
		var lower_bound = 1
		var money_to_gain
		if upgraded:
			lower_bound = 4
		money_to_gain = rng.randi_range(lower_bound, 6)
		Manager.money += money_to_gain
		shopScene.updateText()
		await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, str(money_to_gain))
		await proc()
