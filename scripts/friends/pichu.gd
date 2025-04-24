extends Card


func sell_card(card_colour, _card_cost):
	if not blocked_ability and card_colour == colours.BLUE:
		x += 1
		Manager.move_symbol(global_position, global_position, x_icon, "")
		setStatText()
		await proc()
	elif not blocked_ability and card_colour == colours.YELLOW and upgraded:
		attack += 1
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, "1")
		setStatText()
		await proc()
