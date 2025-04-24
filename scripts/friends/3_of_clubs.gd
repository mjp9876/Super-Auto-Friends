extends Card

func end_turn():
	if not blocked_ability:
		var three_of_clubs_count = 0
		Manager.update_friends()
		for friend in Manager.friends:
			if friend != null:
				if friend.card_name == "3 Of Clubs" or friend.card_name == "3 Of Clubs+":
					three_of_clubs_count += 1
		if three_of_clubs_count >= 3:
			proc()
			hp += 3
			attack += 3
			if upgraded:
				Manager.money += 3
			Manager.move_symbol(global_position, global_position, most_hp_target_texture, "3")
			await get_tree().create_timer(0.2).timeout
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, "3")
			if upgraded:
				await get_tree().create_timer(0.2).timeout
				Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "3")
			setStatText()
			await proc()
