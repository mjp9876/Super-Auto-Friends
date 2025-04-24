extends Card


func friend_ahead_attacks(friend):
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var need_to_proc = false
		if friend.hp > 0:
			await attack_opponent(friend, 1, arena_scene)
			need_to_proc = true
		if upgraded and hp > 0:
			proc()
			need_to_proc = true
			await get_tree().create_timer(0.2).timeout
			hp += 3
			Manager.move_symbol(global_position, global_position, most_hp_target_texture, "3")
			setStatText()
		if need_to_proc:
			await proc()
