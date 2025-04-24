extends Card


func item_ability(target_friend):
	target_friend.target = target_friend.targets.JAMES
	target_friend.setTarget()
	Manager.move_symbol(global_position, target_friend.global_position, james_target_texture, "")
