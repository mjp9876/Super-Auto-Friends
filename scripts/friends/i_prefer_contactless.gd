extends Card


func sell_card(card_colour, _card_cost):
	if not blocked_ability and card_colour == colours.RED:
		Manager.money += 2
		shopScene.updateText()
		await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "2")
		await proc()

func buy_card(card_bought):
	if not blocked_ability and card_bought.colour == colours.GREEN and upgraded:
		hp += 5
		Manager.move_symbol(global_position, global_position, most_hp_target_texture, "5")
		setStatText()
		await proc()
