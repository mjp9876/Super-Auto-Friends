extends Card


func buy():
	if not blocked_ability:
		await buff_shop_friends(false)

func reroll():
	if not blocked_ability:
		await buff_shop_friends(true)

func buff_shop_friends(reroll_version):
	var shop_slots = [0, 1, 2, 3, 4]
	var hp_increase = 14
	proc()
	await get_tree().create_timer(0.5).timeout
	if upgraded:
		hp_increase = 24
	for slot in shop_slots:
		if shopScene.friend_shop_slots[slot].active:
			if shopScene.friend_shop_slots[slot].card.colour == colours.RED and ((not reroll_version) or (reroll_version and not shopScene.friend_shop_slots[slot].card.locked)):
				shopScene.friend_shop_slots[slot].card.hp += hp_increase
				shopScene.friend_shop_slots[slot].card.setStatText()
				Manager.move_symbol(global_position, shopScene.friend_shop_slots[slot].global_position, most_hp_target_texture, str(hp_increase))
	await proc()
