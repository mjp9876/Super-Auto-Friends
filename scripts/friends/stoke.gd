extends Card

func sell():
	if not blocked_ability:
		Manager.money += n
		shopScene.updateText()
		await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, str(n))
		await proc()

func start_turn():
	if not blocked_ability:
		var n_increase = 2
		if upgraded:
			n_increase = 3
		n += n_increase
		Manager.move_symbol(global_position, global_position, plus_icon, "")
		setAbilityText()
		await proc()
