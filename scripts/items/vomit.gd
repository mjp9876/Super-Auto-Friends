extends Card

func item_ability(target_friend):
	target_friend.target = target_friend.targets.MATT
	target_friend.setTarget()
	Manager.move_symbol(global_position, target_friend.global_position, matt_target_texture, "")
