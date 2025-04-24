extends Card


func die(_killers):
	if not blocked_ability and inBattle:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var friend_to_buff = null
		match team_number:
			1:
				friend_to_buff = find_friend_behind(arena_scene.p1cards)
			2:
				friend_to_buff = find_friend_behind(arena_scene.p2cards)
			3:
				friend_to_buff = find_friend_behind(arena_scene.p3cards)
			4:
				friend_to_buff = find_friend_behind(arena_scene.p4cards)
		if friend_to_buff != null:
			proc()
			friend_to_buff.hp += 6
			Manager.move_symbol(global_position, friend_to_buff.global_position, most_hp_target_texture, "6")
			await get_tree().create_timer(0.2).timeout
			if upgraded:
				friend_to_buff.x += 1
				friend_to_buff.this_x = friend_to_buff.x
				Manager.move_symbol(global_position, friend_to_buff.global_position, x_icon, "")
			else:
				friend_to_buff.attack += 1
				Manager.move_symbol(global_position, friend_to_buff.global_position, most_attack_target_texture, "1")
			friend_to_buff.setStatText()
			await proc()
	elif not blocked_ability and not inBattle:
		var target_friend = null
		var slot_position
		var search_position
		slot_position = Manager.friends.find(self)
		search_position = slot_position - 1
		while search_position >= 0:
			if Manager.friends[search_position] != null and Manager.friends[search_position].hp > 0:
				target_friend = Manager.friends[search_position]
				break
			else:
				search_position -= 1
		if target_friend != null:
			proc()
			target_friend.hp += 6
			Manager.move_symbol(global_position, target_friend.global_position, most_hp_target_texture, "6")
			await get_tree().create_timer(0.2).timeout
			if upgraded:
				target_friend.x += 1
				target_friend.this_x = target_friend.x
				Manager.move_symbol(global_position, target_friend.global_position, x_icon, "")
			else:
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
