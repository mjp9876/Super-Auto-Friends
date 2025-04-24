extends Card


func reroll():
	if not blocked_ability:
		proc()
		await get_tree().create_timer(0.2).timeout
		Manager.money += 1
		shopScene.updateText()
		await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "1")
		await proc()

func use_item():
	if not blocked_ability and upgraded:
		Manager.move_symbol(global_position, global_position, reroll_icon, "")
		proc()
		await shopScene.free_reroll()
		await Manager.rerolled()
