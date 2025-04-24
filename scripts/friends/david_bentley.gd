extends Card


func use_item():
	if not blocked_ability:
		proc()
		await get_tree().create_timer(0.5).timeout
		var discount_order = [0, 1, 2, 3, 4]
		for slot in discount_order:
			if shopScene.friend_shop_slots[slot].active and shopScene.friend_shop_slots[slot].card.colour == colours.RED:
				shopScene.friend_shop_slots[slot].card.upgraded = true
				shopScene.friend_shop_slots[slot].card.setAbilityText()
				shopScene.friend_shop_slots[slot].card.setStatText()
				Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, upgrade_icon, "")
		if upgraded:
			proc()
			discount_order = [0, 1, 2, 3, 4]
			for slot in discount_order:
				if shopScene.friend_shop_slots[slot].active and shopScene.friend_shop_slots[slot].card.colour == colours.GREEN:
					shopScene.friend_shop_slots[slot].card.upgraded = true
					shopScene.friend_shop_slots[slot].card.setAbilityText()
					shopScene.friend_shop_slots[slot].card.setStatText()
					Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, upgrade_icon, "")
		await proc()

func sell():
	if not blocked_ability:
		proc()
		await get_tree().create_timer(0.2).timeout
		var discount_order = [0, 1, 2, 3, 4]
		if upgraded:
			for slot in discount_order:
				if shopScene.friend_shop_slots[slot].active and shopScene.friend_shop_slots[slot].card.colour == colours.RED:
					shopScene.friend_shop_slots[slot].card.upgraded = true
					shopScene.friend_shop_slots[slot].card.setAbilityText()
					shopScene.friend_shop_slots[slot].card.setStatText()
					Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, upgrade_icon, "")
		proc()
		discount_order = [0, 1, 2, 3, 4]
		for slot in discount_order:
			if shopScene.friend_shop_slots[slot].active and shopScene.friend_shop_slots[slot].card.colour == colours.GREEN:
				shopScene.friend_shop_slots[slot].card.upgraded = true
				shopScene.friend_shop_slots[slot].card.setAbilityText()
				shopScene.friend_shop_slots[slot].card.setStatText()
				Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, upgrade_icon, "")
		await proc()
