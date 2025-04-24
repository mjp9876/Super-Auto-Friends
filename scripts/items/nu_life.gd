extends Card

func item_ability(target_friend):
	var start_position = global_position
	if target_friend.leader:
		target_friend.hp = min(250, target_friend.hp + int(1 * Manager.item_stat_multiplier))
		Manager.move_symbol(start_position, target_friend.global_position, most_hp_target_texture, str(int(1 * Manager.item_stat_multiplier)))
		target_friend.setStatText()
	else:
		if target_friend.rest_point != null:
			if target_friend.rest_point.card == target_friend:
				target_friend.rest_point.card = null
		target_friend.rest_point = target_friend
		await target_friend.sell()
		Manager.money += target_friend.cost
		shopScene.updateText()
		visible = false
		Manager.move_symbol(target_friend.global_position, shopScene.money_img.global_position, coin_icon, str(target_friend.cost))
		await Manager.card_sold(target_friend)
		target_friend.queue_free()
