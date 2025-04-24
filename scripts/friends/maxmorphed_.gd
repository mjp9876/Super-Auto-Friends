extends Card

func kill(_dead_team, _dead_team_index):
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var hp_to_gain = 9
		var attack_to_gain = 2
		var money_to_gain = 1
		if upgraded:
			hp_to_gain = 12
			attack_to_gain = 3
			money_to_gain = 2
		if hp > 0:
			proc()
			hp += hp_to_gain
			Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(hp_to_gain))
			await get_tree().create_timer(0.2).timeout
		proc()
		attack += attack_to_gain
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_to_gain))
		await get_tree().create_timer(0.2).timeout
		setStatText()
		match team_number:
			1:
				get_the_money(arena_scene, arena_scene.p1stats, money_to_gain, 0)
			2:
				get_the_money(arena_scene, arena_scene.p2stats, money_to_gain, 1)
			3:
				get_the_money(arena_scene, arena_scene.p3stats, money_to_gain, 2)
			4:
				get_the_money(arena_scene, arena_scene.p4stats, money_to_gain, 3)
		await proc()

func get_the_money(arena_scene, player_stat_array, money_to_gain, coin_index):
	player_stat_array[arena_scene.MONEY] += money_to_gain
	arena_scene.update_text()
	Manager.move_symbol(global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_to_gain))

func find_possible_targets(arena_scene, possible_targets):
	if team_number != 1:
		for opponent in arena_scene.p1cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)
	if team_number != 2:
		for opponent in arena_scene.p2cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)
	if team_number != 3:
		for opponent in arena_scene.p3cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)
	if team_number != 4:
		for opponent in arena_scene.p4cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)
