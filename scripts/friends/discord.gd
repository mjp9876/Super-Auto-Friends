extends Card


func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var attack_to_give = 1
		var times_to_give
		var friends_to_buff = []
		if upgraded:
			attack_to_give = 3
		times_to_give = find_video_games(arena_scene)
		await find_team_mates(arena_scene, friends_to_buff)
		for i in range(times_to_give):
			for friend in friends_to_buff:
				proc()
				friend.attack += attack_to_give
				Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, str(attack_to_give))
				await get_tree().create_timer(0.1).timeout
				friend.x += 1
				friend.this_x = friend.x
				Manager.move_symbol(global_position, friend.global_position, x_icon, "")
				await get_tree().create_timer(0.1).timeout
		if times_to_give >= 1:
			await quick_proc()

func find_video_games(arena_scene):
	var found_games = 0
	for opponent in arena_scene.p1cards:
		if opponent.card_name != "ghost" and opponent.catagory == catagories.VIDEO_GAMES:
			found_games += 1
	for opponent in arena_scene.p2cards:
		if opponent.card_name != "ghost" and opponent.catagory == catagories.VIDEO_GAMES:
			found_games += 1
	for opponent in arena_scene.p3cards:
		if opponent.card_name != "ghost" and opponent.catagory == catagories.VIDEO_GAMES:
			found_games += 1
	for opponent in arena_scene.p4cards:
		if opponent.card_name != "ghost" and opponent.catagory == catagories.VIDEO_GAMES:
			found_games += 1
	return found_games

func find_team_mates(arena_scene, possible_targets):
	match team_number:
		1:
			for opponent in arena_scene.p1cards:
				if opponent.card_name != "ghost" and opponent.hp > 0:
					possible_targets.append(opponent)
		2:
			for opponent in arena_scene.p2cards:
				if opponent.card_name != "ghost" and opponent.hp > 0:
					possible_targets.append(opponent)
		3:
			for opponent in arena_scene.p3cards:
				if opponent.card_name != "ghost" and opponent.hp > 0:
					possible_targets.append(opponent)
		4:
			for opponent in arena_scene.p4cards:
				if opponent.card_name != "ghost" and opponent.hp > 0:
					possible_targets.append(opponent)
