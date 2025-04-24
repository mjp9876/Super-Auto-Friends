extends Card


func start_turn():
	if not blocked_ability:
		var discount_order = [0, 1]
		var need_to_proc = false
		await get_tree().create_timer(0.35).timeout
		for slot in discount_order:
			if shopScene.item_shop_slots[slot].active:
				proc()
				need_to_proc = true
				shopScene.item_shop_slots[slot].card.cost = max(0, shopScene.item_shop_slots[slot].card.cost - 2)
				shopScene.item_shop_slots[slot].card.setStatText()
				Manager.move_symbol(global_position, shopScene.item_shop_slots[slot].global_position, coin_icon, "-2")
		if upgraded:
			discount_order = [0, 1, 2, 3, 4]
			for slot in discount_order:
				if shopScene.friend_shop_slots[slot].active and not shopScene.friend_shop_slots[slot].card.locked:
					proc()
					need_to_proc = true
					shopScene.friend_shop_slots[slot].card.cost = max(0, shopScene.friend_shop_slots[slot].card.cost - 2)
					shopScene.friend_shop_slots[slot].card.setStatText()
					Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, coin_icon, "-2")
		if need_to_proc:
			await proc()
