extends Card


func card_specific_rng():
	random_choices = [0, 1, 2, 3, 4, 5]
	random_choices.shuffle()

func die(_killers):
	if not blocked_ability and inBattle:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var friend_to_buff = null
		if upgraded:
			match team_number:
				1:
					friend_to_buff = find_friend_behind(arena_scene.p1cards)
				2:
					friend_to_buff = find_friend_behind(arena_scene.p2cards)
				3:
					friend_to_buff = find_friend_behind(arena_scene.p3cards)
				4:
					friend_to_buff = find_friend_behind(arena_scene.p4cards)
		else:
			match team_number:
				1:
					for i in random_choices:
						if arena_scene.p1cards.size() > i and arena_scene.p1cards[i] != self and arena_scene.p1cards[i].card_name != "ghost":
							friend_to_buff = arena_scene.p1cards[i]
							break
				2:
					for i in random_choices:
						if arena_scene.p2cards.size() > i and arena_scene.p2cards[i] != self and arena_scene.p2cards[i].card_name != "ghost":
							friend_to_buff = arena_scene.p2cards[i]
							break
				3:
					for i in random_choices:
						if arena_scene.p3cards.size() > i and arena_scene.p3cards[i] != self and arena_scene.p3cards[i].card_name != "ghost":
							friend_to_buff = arena_scene.p3cards[i]
							break
				4:
					for i in random_choices:
						if arena_scene.p4cards.size() > i and arena_scene.p4cards[i] != self and arena_scene.p4cards[i].card_name != "ghost":
							friend_to_buff = arena_scene.p4cards[i]
							break
		if friend_to_buff != null:
			friend_to_buff.attack += 1
			Manager.move_symbol(global_position, friend_to_buff.global_position, most_attack_target_texture, "1")
			friend_to_buff.setStatText()
			await proc()
	elif not blocked_ability and not inBattle:
		var target_friend = null
		var slot_position
		var search_position
		if upgraded:
			slot_position = Manager.friends.find(self)
			search_position = slot_position - 1
			while search_position >= 0:
				if Manager.friends[search_position] != null and Manager.friends[search_position].hp > 0:
					target_friend = Manager.friends[search_position]
					break
				else:
					search_position -= 1
		else:
			while target_friend == null or target_friend == self:
				target_friend = Manager.friends.pick_random()
			if Manager.prioritise_leader:
				target_friend = Manager.friends[0]
		if target_friend != null:
			target_friend.attack += 1
			Manager.move_symbol(global_position, target_friend.global_position, most_attack_target_texture, "1")
			target_friend.setStatText()
			await proc()

func find_friend_behind(team):
	var search_position
	var slot_position
	var found_friend = null
	slot_position = team.find(self)
	search_position = slot_position + 1
	while search_position <= team.size() - 1:
		if team[search_position] == null or team[search_position].hp <= 0:
			search_position += 1
		else:
			found_friend = team[search_position]
			break
	return found_friend
