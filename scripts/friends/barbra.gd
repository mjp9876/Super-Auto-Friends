extends Card


func buy():
	if not blocked_ability and not upgraded:
		proc()
		await get_tree().create_timer(1).timeout
		var discount_order = [0, 1]
		for slot in discount_order:
			if shopScene.item_shop_slots[slot].active:
				shopScene.item_shop_slots[slot].card.cost = 0
				shopScene.item_shop_slots[slot].card.setStatText()
				Manager.move_symbol(global_position, shopScene.item_shop_slots[slot].global_position, coin_icon, "0")
		await proc()

func use_item():
	if not blocked_ability and upgraded:
		proc()
		await get_tree().create_timer(1).timeout
		var discount_order = [0, 1]
		for slot in discount_order:
			if shopScene.item_shop_slots[slot].active:
				shopScene.item_shop_slots[slot].card.cost = max(0, shopScene.item_shop_slots[slot].card.cost - 5)
				shopScene.item_shop_slots[slot].card.setStatText()
				Manager.move_symbol(global_position, shopScene.item_shop_slots[slot].global_position, coin_icon, "-5")
		await proc()

func end_turn():
	if not blocked_ability:
		var target_friends = []
		Manager.update_friends()
		for friend in Manager.friends:
			if friend != null:
				if friend.catagory == catagories.PARENTS and friend != self:
					target_friends.append(friend)
		for friend in target_friends:
			proc()
			friend.hp += 4
			friend.attack += 1
			Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "4")
			await get_tree().create_timer(0.2).timeout
			Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, "1")
			friend.setStatText()
			await get_tree().create_timer(0.2).timeout
		if target_friends.size() > 0:
			await proc()
