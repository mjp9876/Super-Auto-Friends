extends Card


func buy_card(card_bought):
	if not blocked_ability and card_bought.colour == colours.GREEN:
		var hp_to_give = 3
		if upgraded:
			hp_to_give = 5
		Manager.update_friends()
		for friend in Manager.friends:
			if friend != null:
				proc()
				friend.hp += hp_to_give
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, str(hp_to_give))
				await get_tree().create_timer(0.2).timeout
				friend.setStatText()
		await proc()
