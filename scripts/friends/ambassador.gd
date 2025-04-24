extends Card


func buy():
	if not blocked_ability and not upgraded:
		Manager.move_symbol(global_position, global_position, reroll_icon, "")
		proc()
		await shopScene.free_reroll()
		await Manager.rerolled()
		await get_tree().create_timer(1).timeout
		var done_discounts = 0
		var discount_order = [0, 1, 2, 3, 4]
		discount_order.shuffle()
		for slot in discount_order:
			if shopScene.friend_shop_slots[slot].active:
				shopScene.friend_shop_slots[slot].card.cost = max(0, shopScene.friend_shop_slots[slot].card.cost - 2)
				shopScene.friend_shop_slots[slot].card.setStatText()
				done_discounts += 1
				Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, coin_icon, "-2")
			if done_discounts == 2:
				break
		await proc()

func sell():
	if not blocked_ability and upgraded:
		await shopScene.free_reroll()
		Manager.move_symbol(global_position, global_position, reroll_icon, "")
		await Manager.rerolled()
		await get_tree().create_timer(1).timeout
		var done_discounts = 0
		var discount_order = [0, 1, 2, 3, 4]
		discount_order.shuffle()
		for slot in discount_order:
			if shopScene.friend_shop_slots[slot].active:
				shopScene.friend_shop_slots[slot].card.cost = max(0, shopScene.friend_shop_slots[slot].card.cost - 3)
				shopScene.friend_shop_slots[slot].card.setStatText()
				done_discounts += 1
				Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, coin_icon, "-3")
			if done_discounts == 2:
				break
