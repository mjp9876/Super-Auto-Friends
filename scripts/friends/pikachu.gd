extends Card


func buy_card(card_bought):
	if not blocked_ability and card_bought.colour == colours.YELLOW:
		proc()
		if upgraded:
			card_bought.upgraded = true
			Manager.move_symbol(global_position, card_bought.global_position, upgrade_icon, "")
			await get_tree().create_timer(0.2).timeout
		card_bought.hp += 8
		Manager.move_symbol(global_position, card_bought.global_position, most_hp_target_texture, "8")
		await get_tree().create_timer(0.2).timeout
		card_bought.attack += 1
		Manager.move_symbol(global_position, card_bought.global_position, most_attack_target_texture, "1")
		card_bought.setAbilityText()
		card_bought.setStatText()
		await proc()
