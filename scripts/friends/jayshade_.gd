extends Card


func use_item():
	if not blocked_ability:
		proc()
		hp += 2
		Manager.move_symbol(global_position, global_position, most_hp_target_texture, "2")
		if upgraded:
			await get_tree().create_timer(0.2).timeout
			attack += 2
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, "2")
		await get_tree().create_timer(0.2).timeout
		setStatText()
		Manager.money += 2
		shopScene.updateText()
		await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "2")
		await proc()
