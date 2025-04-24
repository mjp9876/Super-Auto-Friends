extends Card


func item_ability(target_friend):
	var start_position = global_position
	target_friend.hp += int(5 * Manager.item_stat_multiplier)
	target_friend.attack += int(1 * Manager.item_stat_multiplier)
	Manager.move_symbol(start_position, target_friend.global_position, most_hp_target_texture, str(int(5 * Manager.item_stat_multiplier)))
	await get_tree().create_timer(0.2).timeout
	Manager.move_symbol(start_position, target_friend.global_position, most_attack_target_texture, str(int(1 * Manager.item_stat_multiplier)))
	target_friend.setStatText()
