extends Card


func die(_killers):
	if not blocked_ability and inBattle:
		var times_to_deal_damage = 1
		var damage_to_deal = 3
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var friend_to_attack = null
		if upgraded:
			times_to_deal_damage = 3
			damage_to_deal = 1
		for i in range(times_to_deal_damage):
			match team_number:
				1:
					friend_to_attack = find_friend_behind(arena_scene.p1cards)
				2:
					friend_to_attack = find_friend_behind(arena_scene.p2cards)
				3:
					friend_to_attack = find_friend_behind(arena_scene.p3cards)
				4:
					friend_to_attack = find_friend_behind(arena_scene.p4cards)
			if friend_to_attack != null:
				proc()
				await attack_opponent(friend_to_attack, damage_to_deal, arena_scene)
			await get_tree().create_timer(0.2).timeout
	elif not blocked_ability and not inBattle:
		var times_to_deal_damage_in_shop = 1
		var damage_to_deal_in_shop = 3
		var target_friend = null
		var slot_position
		var search_position
		if upgraded:
			times_to_deal_damage_in_shop = 3
			damage_to_deal_in_shop = 1
		for i in range(times_to_deal_damage_in_shop):
			slot_position = Manager.friends.find(self)
			search_position = slot_position - 1
			while search_position >= 0:
				if Manager.friends[search_position] != null and Manager.friends[search_position].hp > 0:
					target_friend = Manager.friends[search_position]
					break
				else:
					search_position -= 1
			if target_friend != null and target_friend.hp > 0:
				target_friend.hp -= damage_to_deal_in_shop
				Manager.move_symbol(global_position, target_friend.global_position, attack_icon, str(damage_to_deal_in_shop))
				target_friend.setStatText()
				await target_friend.hurt(self)
				await get_tree().create_timer(0.2).timeout
		Manager.kill_friends_in_team()

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
