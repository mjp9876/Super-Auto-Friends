extends Card


func end_turn():
	if not blocked_ability:
		var money_to_steal = 10
		if upgraded:
			money_to_steal = 15
		if Manager.money >= money_to_steal:
			proc()
			var target_friends = []
			var hp_to_give = 5
			var attack_to_give = 1
			if upgraded:
				hp_to_give = 8
				attack_to_give = 3
			Manager.money -= money_to_steal
			shopScene.updateText()
			await Manager.move_symbol(shopScene.money_img.global_position, global_position, coin_icon, str(money_to_steal))
			Manager.update_friends()
			for i in range(6):
				if Manager.friends[i] != self and Manager.friends[i] != null:
					target_friends.append(Manager.friends[i])
			for friend in target_friends:
				proc()
				friend.hp += hp_to_give
				friend.attack += attack_to_give
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, str(hp_to_give))
				await get_tree().create_timer(0.2).timeout
				Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, str(attack_to_give))
				friend.setStatText()
				await get_tree().create_timer(0.2).timeout
			await proc()

