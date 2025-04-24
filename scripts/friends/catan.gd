extends Card


func end_turn():
	if not blocked_ability:
		var shop_slots = [0, 1, 2, 3, 4]
		var hp_increase = 2
		if upgraded:
			hp_increase = 4
		proc()
		await get_tree().create_timer(0.5).timeout
		for slot in shop_slots:
			if shopScene.friend_shop_slots[slot].active:
					shopScene.friend_shop_slots[slot].card.hp += hp_increase
					shopScene.friend_shop_slots[slot].card.setStatText()
					Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, most_hp_target_texture, str(hp_increase))
		Manager.shop_friend_hp_buff += hp_increase
		await proc()
