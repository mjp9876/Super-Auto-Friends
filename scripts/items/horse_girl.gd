extends Card


func item_ability(target_friend):
	target_friend.target = target_friend.targets.HARRY
	target_friend.setTarget()
	Manager.move_symbol(global_position, target_friend.global_position, harry_target_texture, "")
