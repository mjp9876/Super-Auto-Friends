extends Card


func buy_card(card_bought):
	if not blocked_ability:
		if not upgraded:
			card_bought.attack += 1
			Manager.move_symbol(global_position, card_bought.global_position, most_attack_target_texture, "1")
		else:
			card_bought.x += 1
			Manager.move_symbol(global_position, card_bought.global_position, x_icon, "")
		card_bought.setStatText()
		await proc()
