extends Card


func start_turn():
	var need_to_buff = false
	if Manager.playerNum not in Manager.previous_round_winner or upgraded:
		need_to_buff = true
	if not blocked_ability and need_to_buff:
		var shop_slots = [0, 1, 2, 3, 4]
		var attack_increase = 1
		await get_tree().create_timer(0.3).timeout
		for slot in shop_slots:
			if shopScene.friend_shop_slots[slot].active:
				proc()
				shopScene.friend_shop_slots[slot].card.hp += 4
				shopScene.friend_shop_slots[slot].card.setStatText()
				Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, most_hp_target_texture, "4")
				await get_tree().create_timer(0.2).timeout
				shopScene.friend_shop_slots[slot].card.attack += attack_increase
				shopScene.friend_shop_slots[slot].card.setStatText()
				Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, most_attack_target_texture, str(attack_increase))
		Manager.shop_friend_hp_buff += 4
		Manager.shop_friend_attack_buff += attack_increase
		await proc()
