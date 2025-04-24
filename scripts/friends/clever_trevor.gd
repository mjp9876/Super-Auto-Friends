extends Card


func end_turn():
	if not blocked_ability:
		Manager.update_friends()
		var target_friends = []
		var need_to_proc = false
		for friend in Manager.friends:
			if friend != null:
				if friend.catagory == catagories.TEACHERS and friend != self:
					target_friends.append(friend)
		target_friends.shuffle()
		while target_friends.size() > 0:
			proc()
			need_to_proc = true
			target_friends[0].x += 1
			Manager.move_symbol(global_position, target_friends[0].global_position, x_icon, "")
			target_friends[0].setStatText()
			if upgraded:
				target_friends.pop_front()
				await get_tree().create_timer(0.2).timeout
			else:
				target_friends = []
		if need_to_proc:
			await proc()

func kill(_dead_team, _dead_team_index):
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var target_friend = null
		match team_number:
			1:
				target_friend = arena_scene.p1cards[-1]
			2:
				target_friend = arena_scene.p2cards[-1]
			3:
				target_friend = arena_scene.p3cards[-1]
			4:
				target_friend = arena_scene.p4cards[-1]
		if target_friend != null:
			proc()
			if upgraded:
				target_friend.attack += 1
				Manager.move_symbol(global_position, target_friend.global_position, most_attack_target_texture, "1")
				await get_tree().create_timer(0.2).timeout
			target_friend.x += 1
			target_friend.this_x += 1
			Manager.move_symbol(global_position, target_friend.global_position, x_icon, "")
			await proc()
