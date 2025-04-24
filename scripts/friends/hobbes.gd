extends Card


func start_turn():
	if not blocked_ability:
		proc()
		await get_tree().create_timer(0.5).timeout
		var discount_order = [0, 1]
		var discount_amount = 4
		if upgraded:
			discount_amount = 7
		for slot in discount_order:
			if shopScene.item_shop_slots[slot].active:
				shopScene.item_shop_slots[slot].card.cost = max(0, shopScene.item_shop_slots[slot].card.cost - discount_amount)
				shopScene.item_shop_slots[slot].card.setStatText()
				Manager.move_symbol(global_position, shopScene.item_shop_slots[slot].global_position, coin_icon, "-" + str(discount_amount))
		await proc()
