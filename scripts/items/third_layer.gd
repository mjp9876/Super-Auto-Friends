extends Card


func item_ability(target_friend):
	var new_colour = rng.randi_range(0, 3)
	var new_target = rng.randi_range(0, targets.size() - 1)
	target_friend.colour = new_colour
	target_friend.target = new_target
	target_friend.setColour()
	target_friend.setTarget()
	Manager.move_symbol(global_position, target_friend.global_position, find_colour_icon(new_colour), "")
	await get_tree().create_timer(0.2).timeout
	Manager.move_symbol(global_position, target_friend.global_position, find_target_icon(new_target), "")
