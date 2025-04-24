extends Card


func buy_card(card_bought):
	if not blocked_ability and card_bought.colour == colours.GREEN:
		var hp_to_give = 12
		if upgraded:
			hp_to_give = 22
		card_bought.hp += hp_to_give
		Manager.move_symbol(global_position, card_bought.global_position, most_hp_target_texture, str(hp_to_give))
		card_bought.setStatText()
		await proc()
