extends Card


func friend_summoned(new_friend):
	if not blocked_ability and inBattle:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var friend_to_buff = null
		match team_number:
			1:
				friend_to_buff = find_friend_ahead(arena_scene.p1cards)
			2:
				friend_to_buff = find_friend_ahead(arena_scene.p2cards)
			3:
				friend_to_buff = find_friend_ahead(arena_scene.p3cards)
			4:
				friend_to_buff = find_friend_ahead(arena_scene.p4cards)
		if friend_to_buff != null:
			await give_stats(friend_to_buff)
		if upgraded and new_friend != null and new_friend != friend_to_buff:
			await give_stats(new_friend)
		await proc()

func give_stats(receiver):
	proc()
	receiver.hp += 10
	Manager.move_symbol(global_position, receiver.global_position, most_hp_target_texture, "10")
	await get_tree().create_timer(0.2).timeout
	receiver.attack += 2
	Manager.move_symbol(global_position, receiver.global_position, most_attack_target_texture, "2")
	await get_tree().create_timer(0.2).timeout
	receiver.x += 1
	if not receiver.active:
		receiver.this_x = receiver.x
	Manager.move_symbol(global_position, receiver.global_position, x_icon, "")

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
