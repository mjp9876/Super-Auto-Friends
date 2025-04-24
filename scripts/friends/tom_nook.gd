extends Card


func end_turn():
	if not blocked_ability and Manager.money > 0:
		var target_friend = null
		var hp_to_give = 3
		var times_to_give_hp = Manager.money
		if upgraded:
			hp_to_give = 6
		Manager.money = 0
		shopScene.updateText()
		await Manager.move_symbol(shopScene.money_img.global_position, global_position, coin_icon, str(times_to_give_hp))
		Manager.update_friends()
		for i in times_to_give_hp:
			proc()
			while target_friend == null or target_friend == self:
				target_friend = Manager.friends.pick_random()
			if Manager.prioritise_leader:
				target_friend = Manager.friends[0]
			target_friend.hp += hp_to_give
			Manager.move_symbol(global_position, target_friend.global_position, most_hp_target_texture, str(hp_to_give))
			await get_tree().create_timer(0.1).timeout
			target_friend.setStatText()
			target_friend = null
		await proc()
