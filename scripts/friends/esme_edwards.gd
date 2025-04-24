extends Card


func friend_uses_item(friend):
	if not blocked_ability and friend != null:
		friend.hp += 5
		Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "5")
		if upgraded:
			proc()
			await get_tree().create_timer(0.2).timeout
			friend.attack += 1
			Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, "1")
		friend.setStatText()
		await proc()
