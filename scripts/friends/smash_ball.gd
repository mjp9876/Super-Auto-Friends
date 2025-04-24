extends Card


func card_specific_rng():
	random_choices = [0, 1, 2, 3, 4, 5]
	random_choices.shuffle()


func start_turn():
	if not blocked_ability:
		var random_colour
		var random_colour_icon
		random_colour = colours.values().pick_random()
		while random_colour == colour or random_colour == colours.ITEM or random_colour == colours.CHANGE:
			random_colour = colours.values().pick_random()
		random_colour_icon = find_colour_icon(random_colour)
		colour = random_colour
		Manager.move_symbol(global_position, global_position, random_colour_icon, "")
		setColour()
		await proc()


func die(_killers):
	if not blocked_ability and inBattle:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var friend_to_buff = null
		var hp_to_give = 10
		var attack_to_give = 3
		if upgraded:
			hp_to_give = 25
			attack_to_give = 5
		match team_number:
			1:
				for i in random_choices:
					if arena_scene.p1cards.size() > i and arena_scene.p1cards[i] != self and arena_scene.p1cards[i].card_name != "ghost" and arena_scene.p1cards[i].catagory == catagories.SUPER_SMASH_BROS:
						friend_to_buff = arena_scene.p1cards[i]
						break
			2:
				for i in random_choices:
					if arena_scene.p2cards.size() > i and arena_scene.p2cards[i] != self and arena_scene.p2cards[i].card_name != "ghost" and arena_scene.p2cards[i].catagory == catagories.SUPER_SMASH_BROS:
						friend_to_buff = arena_scene.p2cards[i]
						break
			3:
				for i in random_choices:
					if arena_scene.p3cards.size() > i and arena_scene.p3cards[i] != self and arena_scene.p3cards[i].card_name != "ghost" and arena_scene.p3cards[i].catagory == catagories.SUPER_SMASH_BROS:
						friend_to_buff = arena_scene.p3cards[i]
						break
			4:
				for i in random_choices:
					if arena_scene.p4cards.size() > i and arena_scene.p4cards[i] != self and arena_scene.p4cards[i].card_name != "ghost" and arena_scene.p4cards[i].catagory == catagories.SUPER_SMASH_BROS:
						friend_to_buff = arena_scene.p4cards[i]
						break
		if friend_to_buff != null:
			proc()
			friend_to_buff.hp += hp_to_give
			Manager.move_symbol(global_position, friend_to_buff.global_position, most_hp_target_texture, str(hp_to_give))
			await get_tree().create_timer(0.2).timeout
			friend_to_buff.attack += attack_to_give
			Manager.move_symbol(global_position, friend_to_buff.global_position, most_attack_target_texture, str(attack_to_give))
			friend_to_buff.setStatText()
			await proc()
	elif not blocked_ability and not inBattle:
		var target_friend = null
		var hp_to_give = 10
		var attack_to_give = 3
		Manager.update_friends()
		if upgraded:
			hp_to_give = 25
			attack_to_give = 5
		if Manager.friends.any(smash_char_in_arr):
			while target_friend == null or target_friend == self or target_friend.catagory != catagories.SUPER_SMASH_BROS:
				target_friend = Manager.friends.pick_random()
			if target_friend != null:
				proc()
				target_friend.hp += hp_to_give
				Manager.move_symbol(global_position, target_friend.global_position, most_hp_target_texture, str(hp_to_give))
				await get_tree().create_timer(0.2).timeout
				target_friend.attack += attack_to_give
				Manager.move_symbol(global_position, target_friend.global_position, most_attack_target_texture, str(attack_to_give))
				target_friend.setStatText()
				await proc()

func smash_char_in_arr(x):
	if x != null:
		return x.catagory == catagories.SUPER_SMASH_BROS
	else:
		return false
