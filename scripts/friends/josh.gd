extends Card


func start_turn():
	if not blocked_ability:
		Manager.money += 1
		Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "1")
		shopScene.updateText()
		await proc()
