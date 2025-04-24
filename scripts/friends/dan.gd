extends Card


func die(_killers):
	if not blocked_ability and inBattle:
		var times_to_deal_damage = 1
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		if upgraded:
			times_to_deal_damage = 2
		for i in range(times_to_deal_damage):
			find_possible_targets(arena_scene, possible_targets)
			possible_targets.sort_custom(sort_hp)
			while possible_targets.size() > 0:
				proc()
				await attack_opponent(possible_targets[0], 6, arena_scene)
				await get_tree().create_timer(0.02).timeout
				possible_targets.pop_front()
		await proc()
	elif not blocked_ability and not inBattle:
		Manager.update_friends()
		var times_to_deal_damage_in_shop = 1
		if upgraded:
			times_to_deal_damage_in_shop = 2
		for i in range(times_to_deal_damage_in_shop):
			for friend in Manager.friends:
				if friend != null and friend.hp > 0:
					friend.hp -= 6
					Manager.move_symbol(global_position, friend.global_position, attack_icon, "6")
					friend.setStatText()
					await friend.hurt(self)
					await get_tree().create_timer(0.05).timeout
		Manager.kill_friends_in_team()
		await proc()

func sort_hp(a, b):
	if a.hp > b.hp:
		return true
	return false

func find_possible_targets(arena_scene, possible_targets):
	for opponent in arena_scene.p1cards:
		if opponent.card_name != "ghost" and opponent.hp > 0:
			possible_targets.append(opponent)
	for opponent in arena_scene.p2cards:
		if opponent.card_name != "ghost" and opponent.hp > 0:
			possible_targets.append(opponent)
	for opponent in arena_scene.p3cards:
		if opponent.card_name != "ghost" and opponent.hp > 0:
			possible_targets.append(opponent)
	for opponent in arena_scene.p4cards:
		if opponent.card_name != "ghost" and opponent.hp > 0:
			possible_targets.append(opponent)
