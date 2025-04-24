extends Card


func end_turn():
	if not blocked_ability and not upgraded:
		Manager.update_friends()
		var target_friend = null
		var slot_position
		var search_position
		slot_position = Manager.friends.find(self)
		search_position = slot_position + 1
		while search_position < 6:
			if Manager.friends[search_position] == null:
				search_position += 1
			else:
				target_friend = Manager.friends[search_position]
				break
		if target_friend != null:
			proc()
			Manager.move_symbol(global_position, target_friend.global_position, yellow_icon, "")
			await get_tree().create_timer(0.35).timeout
			target_friend.colour = colours.YELLOW
			target_friend.setColour()
			await proc()

func sell():
	if not blocked_ability and upgraded:
		var shop_slots = [0, 1, 2, 3, 4]
		await get_tree().create_timer(0.3).timeout
		for i in shop_slots:
			if shopScene.friend_shop_slots[shop_slots[i]].active:
				proc()
				shopScene.friend_shop_slots[shop_slots[i]].card.colour = colours.YELLOW
				shopScene.friend_shop_slots[shop_slots[i]].card.setColour()
				Manager.move_symbol(global_position, shopScene.friend_shop_slots[shop_slots[i]].global_position, yellow_icon, "")
				await Manager.get_tree().create_timer(0.15).timeout
		await proc()
