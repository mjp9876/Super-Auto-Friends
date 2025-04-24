extends Card


func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var colour_counts = [0, 0, 0, 0]
		var multiplier = 2
		var target_friend = null
		if upgraded:
			multiplier = 4
		colour_counts = find_colour_counts(arena_scene)
		colour_counts.sort()
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
			target_friend.hp += colour_counts[-1] * multiplier
			Manager.move_symbol(global_position, target_friend.global_position, most_hp_target_texture, str(colour_counts[-1] * multiplier))
			await proc()

func find_colour_counts(arena_scene):
	var colour_count = [0, 0, 0, 0]
	for opponent in arena_scene.p1cards:
		if opponent.card_name != "ghost":
			colour_count[opponent.colour] += 1
	for opponent in arena_scene.p2cards:
		if opponent.card_name != "ghost":
			colour_count[opponent.colour] += 1
	for opponent in arena_scene.p3cards:
		if opponent.card_name != "ghost":
			colour_count[opponent.colour] += 1
	for opponent in arena_scene.p4cards:
		if opponent.card_name != "ghost":
			colour_count[opponent.colour] += 1
	return colour_count
