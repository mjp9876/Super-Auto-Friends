extends Card

func sell():
	if not blocked_ability:
		var cards_to_upgrade = 2
		if upgraded:
			cards_to_upgrade = 4
		await shopScene.free_reroll()
		Manager.move_symbol(global_position, global_position, reroll_icon, "")
		await Manager.rerolled()
		await get_tree().create_timer(1).timeout
		var done_discounts = 0
		var discount_order = [0, 1, 2, 3, 4]
		
		discount_order.shuffle()
		for slot in discount_order:
			if shopScene.friend_shop_slots[slot].active:
				shopScene.friend_shop_slots[slot].card.upgraded = true
				shopScene.friend_shop_slots[slot].card.setStatText()
				shopScene.friend_shop_slots[slot].card.setAbilityText()
				done_discounts += 1
				Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, upgrade_icon, "")
			if done_discounts == cards_to_upgrade:
				break
