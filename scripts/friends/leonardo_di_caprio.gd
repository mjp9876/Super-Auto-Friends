extends Card


func end_turn():
	if not blocked_ability:
		Manager.update_friends()
		var need_to_proc = false
		if not upgraded:
			for friend in Manager.friends:
				if friend != null and friend.hp <= 25:
					proc()
					need_to_proc = true
					friend.hp += 15
					Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "15")
					await get_tree().create_timer(0.15).timeout
					friend.setStatText()
		else:
			for friend in Manager.friends:
				if friend != null and friend.attack <= 7:
					proc()
					need_to_proc = true
					friend.attack += 3
					Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, "1")
					await get_tree().create_timer(0.15).timeout
					friend.setStatText()
		if need_to_proc:
			await proc()
