extends Card


func end_turn():
	if not blocked_ability:
		var hp_to_give = 4
		var target_friend = null
		if upgraded:
			hp_to_give = 6
		while target_friend == null or target_friend == self:
			target_friend = Manager.friends.pick_random()
		if Manager.prioritise_leader:
			target_friend = Manager.friends[0]
		target_friend.hp += hp_to_give
		Manager.move_symbol(global_position, target_friend.global_position, most_hp_target_texture, str(hp_to_give))
		target_friend.setStatText()
		await proc()

func buy_card(card_bought):
	if not blocked_ability and card_bought.colour == colours.RED:
		var hp_to_lose = 10
		if upgraded:
			hp_to_lose = 3
		hp = max(1, hp - hp_to_lose)
		Manager.move_symbol(global_position, global_position, least_hp_target_texture, str(hp_to_lose))
		setStatText()
		await proc()
