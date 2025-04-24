extends Card


func item_ability(target_friend):
	var start_position = global_position
	target_friend.x += int(1 * Manager.item_stat_multiplier)
	Manager.move_symbol(start_position, target_friend.global_position, x_icon, str(int(1 * Manager.item_stat_multiplier)))
	target_friend.setStatText()
