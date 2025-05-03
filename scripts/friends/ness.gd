extends Card


func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var times_to_attack = 4
		var friend_ahead = null
		match team_number:
			1:
				friend_ahead = find_friend_ahead(arena_scene.p1cards)
			2:
				friend_ahead = find_friend_ahead(arena_scene.p2cards)
			3:
				friend_ahead = find_friend_ahead(arena_scene.p3cards)
			4:
				friend_ahead = find_friend_ahead(arena_scene.p4cards)
		if upgraded:
			times_to_attack = 8
		if friend_ahead == null:
			var possible_targets = []
			find_possible_targets(arena_scene, possible_targets)
			for i in range(times_to_attack):
				proc()
				for opponent in possible_targets:
					if opponent.hp > 0:
						await attack_opponent(opponent, 3, arena_scene)
			await proc()
		else:
			for i in range(times_to_attack):
				proc()
				match team_number:
					1:
						friend_ahead = find_friend_ahead(arena_scene.p1cards)
					2:
						friend_ahead = find_friend_ahead(arena_scene.p2cards)
					3:
						friend_ahead = find_friend_ahead(arena_scene.p3cards)
					4:
						friend_ahead = find_friend_ahead(arena_scene.p4cards)
				if friend_ahead != null:
					await attack_opponent(friend_ahead, 3, arena_scene)
			await proc()

func find_friend_ahead(team):
	var search_position
	var slot_position
	var found_friend = null
	slot_position = team.find(self)
	search_position = slot_position - 1
	while search_position >= 0:
		if team[search_position] == null or team[search_position].hp <= 0:
			search_position -= 1
		else:
			found_friend = team[search_position]
			break
	return found_friend

func find_possible_targets(arena_scene, possible_targets):
	if team_number != 1:
		if arena_scene.p1cards[0].card_name != "ghost" and arena_scene.p1cards[0].hp > 0:
			possible_targets.append(arena_scene.p1cards[0])
	if team_number != 2:
		if arena_scene.p2cards[0].card_name != "ghost" and arena_scene.p2cards[0].hp > 0:
			possible_targets.append(arena_scene.p2cards[0])
	if team_number != 3:
		if arena_scene.p3cards[0].card_name != "ghost" and arena_scene.p3cards[0].hp > 0:
			possible_targets.append(arena_scene.p3cards[0])
	if team_number != 4:
		if arena_scene.p4cards[0].card_name != "ghost" and arena_scene.p4cards[0].hp > 0:
			possible_targets.append(arena_scene.p4cards[0])
