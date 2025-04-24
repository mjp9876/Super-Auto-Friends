extends Card


func item_ability(target_friend):
	var start_position = global_position
	if target_friend.leader:
		target_friend.hp = min(250, target_friend.hp + int(1 * Manager.item_stat_multiplier))
		Manager.move_symbol(start_position, target_friend.global_position, most_hp_target_texture, str(int(1 * Manager.item_stat_multiplier)))
		target_friend.setStatText()
	else:
		Manager.move_symbol(global_position, target_friend.global_position, attack_icon, str(target_friend.hp))
		await target_friend.die([])
		Manager.friend_died_in_shop(target_friend.catagory)
		target_friend.queue_free()
