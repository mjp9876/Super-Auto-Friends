extends Card


func friend_uses_item(_friend):
	if not blocked_ability:
		proc()
		await get_tree().create_timer(0.2).timeout
		var discount_order = [0, 1]
		var done_discounts = 0
		discount_order.shuffle()
		for slot in discount_order:
			if shopScene.item_shop_slots[slot].active:
				shopScene.item_shop_slots[slot].card.cost = max(0, shopScene.item_shop_slots[slot].card.cost - 1)
				shopScene.item_shop_slots[slot].card.setStatText()
				Manager.move_symbol(global_position, shopScene.item_shop_slots[slot].global_position, coin_icon, "-1")
				done_discounts += 1
			if not upgraded and done_discounts > 0:
				break
		await proc()
