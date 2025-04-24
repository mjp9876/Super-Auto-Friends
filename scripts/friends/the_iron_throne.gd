extends Card


func buy_card(card_bought):
	if not blocked_ability and card_bought.colour == colours.GREEN:
		Manager.money += 2
		shopScene.updateText()
		await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "2")
		await proc()

func sell_card(card_colour, _card_cost):
	if not blocked_ability and card_colour == colours.GREEN and upgraded:
		var shop_slots = [0, 1, 2, 3, 4]
		var cards_to_set_colour = 1
		var done = false
		var done_changes = 0
		shop_slots.shuffle()
		await get_tree().create_timer(0.3).timeout
		while not done:
			proc()
			while not shopScene.friend_shop_slots[shop_slots[0]].active:
				shop_slots.pop_front()
				if shop_slots.size() == 0:
					done = true
					break
			if not done:
				shopScene.friend_shop_slots[shop_slots[0]].card.colour = colours.GREEN
				shopScene.friend_shop_slots[shop_slots[0]].card.setColour()
				Manager.move_symbol(global_position, shopScene.friend_shop_slots[shop_slots[0]].global_position, green_icon, "")
				done_changes += 1
				shop_slots.pop_front()
				await Manager.get_tree().create_timer(0.2).timeout
			if done_changes >= cards_to_set_colour or shop_slots.size() == 0:
				done = true
		await proc()
