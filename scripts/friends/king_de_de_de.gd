extends Card


func reroll():
	if not blocked_ability and shopScene.reroll_cost <= 2:
		var shop_slots = [0, 1, 2, 3, 4]
		proc()
		await get_tree().create_timer(0.3).timeout
		for slot in shop_slots:
			if shopScene.friend_shop_slots[slot].active and shopScene.friend_shop_slots[slot].card.colour == colours.GREEN:
				proc()
				await get_tree().create_timer(0.2).timeout
				if upgraded:
					shopScene.friend_shop_slots[slot].card.hp += 15
					Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, most_hp_target_texture, "15")
					await get_tree().create_timer(0.1).timeout
				shopScene.friend_shop_slots[slot].card.attack += 1
				Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, most_attack_target_texture, "1")
				shopScene.friend_shop_slots[slot].card.setStatText()
		await proc()
