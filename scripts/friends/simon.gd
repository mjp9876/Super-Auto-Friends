extends Card


func end_turn():
	if not blocked_ability:
		var slot1 = shopScene.item_shop_slots[1]
		var slot2 = shopScene.item_shop_slots[0]
		var item1
		var item2
		Manager.update_friends()
		if slot1.active:
			proc()
			item1 = slot1.card
			item1.rest_point.card = null
			item1.rest_point = Manager.friends[0]
			await get_tree().create_timer(0.5).timeout
			await item1.item_bought(Manager.friends[0])
			item1.queue_free()
		if slot2.active and upgraded:
			proc()
			item2 = slot2.card
			item2.rest_point.card = null
			item2.rest_point = Manager.friends[0]
			await get_tree().create_timer(0.5).timeout
			await item2.item_bought(Manager.friends[0])
			item2.queue_free()
		await proc()
		await get_tree().create_timer(0.3).timeout
