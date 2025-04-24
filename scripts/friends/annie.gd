extends Card


func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var target_friend = null
		match team_number:
			1:
				target_friend = find_friend_to_buff(arena_scene.p1cards)
			2:
				target_friend = find_friend_to_buff(arena_scene.p2cards)
			3:
				target_friend = find_friend_to_buff(arena_scene.p3cards)
			4:
				target_friend = find_friend_to_buff(arena_scene.p4cards)
		if target_friend != null:
			proc()
			target_friend.attack += 6
			Manager.move_symbol(global_position, target_friend.global_position, most_attack_target_texture, "6")
			if upgraded:
				await get_tree().create_timer(0.2).timeout
				target_friend.x += 2
				target_friend.this_x += 2
				Manager.move_symbol(global_position, target_friend.global_position, x_icon, "2")
			await proc()

func find_friend_to_buff(team):
	var search_position
	var slot_position
	slot_position = team.find(self)
	search_position = slot_position - 1
	while search_position >= 0:
		if team[search_position] == null or team[search_position].hp <= 0:
			search_position -= 1
		else:
			return team[search_position]
