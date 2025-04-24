extends Card


func sell():
	if not blocked_ability:
		await Manager.update_friends()
		proc()
		for friend in Manager.friends:
			if friend != null:
				if not upgraded:
					friend.attack += 2
					Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, "2")
				if upgraded:
					friend.x += 1
					Manager.move_symbol(global_position, friend.global_position, x_icon, "1")
				friend.setStatText()
				await get_tree().create_timer(0.2).timeout
