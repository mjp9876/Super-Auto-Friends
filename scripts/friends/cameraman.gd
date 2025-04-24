extends Card


func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var target_friend = null
		var target_friends = []
		match team_number:
			1:
				target_friend = find_friend_to_buff(arena_scene.p1cards)
			2:
				target_friend = find_friend_to_buff(arena_scene.p2cards)
			3:
				target_friend = find_friend_to_buff(arena_scene.p3cards)
			4:
				target_friend = find_friend_to_buff(arena_scene.p4cards)
		if upgraded:
			match team_number:
				1:
					target_friends.append_array(find_schmerlock_friends(arena_scene.p1cards))
				2:
					target_friends.append_array(find_schmerlock_friends(arena_scene.p2cards))
				3:
					target_friends.append_array(find_schmerlock_friends(arena_scene.p3cards))
				4:
					target_friends.append_array(find_schmerlock_friends(arena_scene.p4cards))
		if target_friend != null:
			proc()
			target_friend.hp += 7
			Manager.move_symbol(global_position, target_friend.global_position, most_hp_target_texture, "7")
			await get_tree().create_timer(0.2).timeout
		if target_friends.size() > 0:
			for friend in target_friends:
				friend.hp += 10
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "10")
				await get_tree().create_timer(0.2).timeout
		if target_friend != null or target_friends.size() > 0:
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

func find_schmerlock_friends(team):
	var schmerlock_friends = []
	for friend in team:
		if friend.catagory == catagories.SCHMERLOCK:
			schmerlock_friends.append(friend)
	return schmerlock_friends
