extends Card


func reroll():
	if not blocked_ability:
		var hp_to_give = 2
		var target_friend = null
		if upgraded:
			hp_to_give = 5
		Manager.update_friends()
		while target_friend == null or target_friend == self:
			target_friend = Manager.friends.pick_random()
		if Manager.prioritise_leader:
			target_friend = Manager.friends[0]
		target_friend.hp += hp_to_give
		Manager.move_symbol(global_position, target_friend.global_position, most_hp_target_texture, str(hp_to_give))
		target_friend.setStatText()
		await proc()
