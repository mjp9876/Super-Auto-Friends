extends Card


func sell_card(card_colour, card_cost):
	if not blocked_ability and (card_colour == colours.RED or card_colour == colours.BLUE  or upgraded):
		hp += card_cost * 2
		Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(card_cost * 2))
		setStatText()
		await proc()
