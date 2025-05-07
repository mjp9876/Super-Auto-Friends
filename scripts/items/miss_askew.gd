extends Card


func item_ability(_target_friend):
	var shop_slots = [0, 1, 2, 3, 4]
	await get_tree().create_timer(0.3).timeout
	for slot in shop_slots:
		if shopScene.friend_shop_slots[slot].active:
			proc()
			shopScene.friend_shop_slots[slot].card.hp += 5
			shopScene.friend_shop_slots[slot].card.setStatText()
			Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, most_hp_target_texture, "5")
			await get_tree().create_timer(0.2).timeout
			shopScene.friend_shop_slots[slot].card.attack += 1
			shopScene.friend_shop_slots[slot].card.setStatText()
			Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, most_attack_target_texture, "1")
	Manager.shop_friend_hp_buff += 5
	Manager.shop_friend_attack_buff += 1
