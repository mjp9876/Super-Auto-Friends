extends Card


func start_turn():
	if not blocked_ability:
		await upgrade_everything()

func reroll():
	if not blocked_ability and upgraded:
		await upgrade_everything()

func upgrade_everything():
	proc()
	await get_tree().create_timer(0.3).timeout
	var upgrade_order = [0, 1, 2, 3, 4]
	for slot in upgrade_order:
		if shopScene.friend_shop_slots[slot].active:
			shopScene.friend_shop_slots[slot].card.upgraded = true
			shopScene.friend_shop_slots[slot].card.setAbilityText()
			shopScene.friend_shop_slots[slot].card.setStatText()
			Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, upgrade_icon, "")
	await proc()
