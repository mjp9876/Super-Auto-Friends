extends Card


func reroll():
	if not blocked_ability:
		var shop_slots = [0, 1, 2, 3, 4]
		proc()
		await get_tree().create_timer(0.3).timeout
		for slot in shop_slots:
			if shopScene.friend_shop_slots[slot].active and shopScene.friend_shop_slots[slot].card.colour == colours.BLUE:
				proc()
				await get_tree().create_timer(0.2).timeout
				shopScene.friend_shop_slots[slot].card.hp += n
				Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, most_hp_target_texture, str(n))
				shopScene.friend_shop_slots[slot].card.setStatText()
		await proc()

func end_turn():
	if not blocked_ability:
		var n_cap = 20
		var increase_amount = 4
		if upgraded:
			n_cap = 30
			increase_amount = 8
		if n < n_cap:
			n = min(n_cap, n + increase_amount)
			Manager.move_symbol(global_position, global_position, plus_icon, "")
			setAbilityText()
			await proc()
