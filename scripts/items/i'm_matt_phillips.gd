extends Card


func item_ability(target_friend):
	target_friend.colour = target_friend.colours.RED
	target_friend.setColour()
	Manager.move_symbol(global_position, target_friend.global_position, red_icon, "")
