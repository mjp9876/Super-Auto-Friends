extends Card


func item_ability(target_friend):
	var start_position = global_position
	target_friend.hp += int(10 * Manager.item_stat_multiplier)
	Manager.move_symbol(start_position, target_friend.global_position, most_hp_target_texture, str(int(10 * Manager.item_stat_multiplier)))
	target_friend.setStatText()
