extends Card


func buy_card(card_bought):
	if not blocked_ability and card_bought.colour == colours.RED:
		var options = ["hp", "attack"]
		if upgraded:
			options = ["hp", "hp+", "attack", "attack+"]
		match options.pick_random():
			"hp":
				hp += 5
				Manager.move_symbol(global_position, global_position, most_hp_target_texture, "5")
			"attack":
				attack += 1
				Manager.move_symbol(global_position, global_position, most_attack_target_texture, "1")
			"hp+":
				hp += 15
				Manager.move_symbol(global_position, global_position, most_hp_target_texture, "15")
			"attack+":
				attack += 3
				Manager.move_symbol(global_position, global_position, most_attack_target_texture, "3")
		setStatText()
		await proc()
