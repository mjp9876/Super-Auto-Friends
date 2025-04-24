extends Card


func buy():
	if not blocked_ability and not upgraded:
		await Manager.update_friends()
		var need_to_proc = false
		for friend in Manager.friends:
			if friend != null and friend.colour == colours.YELLOW:
				proc()
				need_to_proc = true
				friend.hp += 12
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "12")
				await get_tree().create_timer(0.2).timeout
				friend.setStatText()
		if need_to_proc:
			await proc()

func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var friends_to_buff = []
		var need_to_proc = false
		if upgraded:
			await find_team_mates(arena_scene, friends_to_buff)
		await find_dogs(arena_scene, friends_to_buff)
		for friend in friends_to_buff:
			need_to_proc = true
			proc()
			friend.hp += 12
			Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "12")
			await get_tree().create_timer(0.2).timeout
		if need_to_proc:
			await proc()

func find_team_mates(arena_scene, possible_targets):
	match team_number:
		1:
			for opponent in arena_scene.p1cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.YELLOW:
					possible_targets.append(opponent)
		2:
			for opponent in arena_scene.p2cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.YELLOW:
					possible_targets.append(opponent)
		3:
			for opponent in arena_scene.p3cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.YELLOW:
					possible_targets.append(opponent)
		4:
			for opponent in arena_scene.p4cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.colour == colours.YELLOW:
					possible_targets.append(opponent)

func find_dogs(arena_scene, possible_targets):
	match team_number:
		1:
			for opponent in arena_scene.p1cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.catagory == catagories.DOG:
					possible_targets.append(opponent)
		2:
			for opponent in arena_scene.p2cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.catagory == catagories.DOG:
					possible_targets.append(opponent)
		3:
			for opponent in arena_scene.p3cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.catagory == catagories.DOG:
					possible_targets.append(opponent)
		4:
			for opponent in arena_scene.p4cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent.catagory == catagories.DOG:
					possible_targets.append(opponent)
