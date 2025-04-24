extends Card


func buy():
	if not blocked_ability and not upgraded:
		proc()
		await get_tree().create_timer(0.5).timeout
		var done_discounts = 0
		var discount_order = [0, 1, 2, 3, 4]
		discount_order.shuffle()
		for slot in discount_order:
			if shopScene.friend_shop_slots[slot].active:
				shopScene.friend_shop_slots[slot].card.cost = 0
				shopScene.friend_shop_slots[slot].card.setStatText()
				done_discounts += 1
				Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, coin_icon, "0")
			if done_discounts == 2:
				break
		await proc()

func use_item():
	if not blocked_ability and upgraded:
		proc()
		await get_tree().create_timer(0.5).timeout
		var done_discounts = 0
		var discount_order = [0, 1, 2, 3, 4]
		discount_order.shuffle()
		for slot in discount_order:
			if shopScene.friend_shop_slots[slot].active:
				shopScene.friend_shop_slots[slot].card.cost = 0
				shopScene.friend_shop_slots[slot].card.setStatText()
				done_discounts += 1
				Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, coin_icon, "0")
			if done_discounts == 1:
				break
		await proc()
