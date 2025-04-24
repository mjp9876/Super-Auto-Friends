extends Card


func kill(_dead_team, _dead_team_index):
	if not blocked_ability:
		var money_to_get = 2
		var hp_to_get = 8
		var arena_scene = get_tree().get_first_node_in_group("arena")
		if upgraded:
			money_to_get = 3
			hp_to_get = 12
		proc()
		match team_number:
			1:
				get_the_money(arena_scene, arena_scene.p1stats, money_to_get, 0)
			2:
				get_the_money(arena_scene, arena_scene.p2stats, money_to_get, 1)
			3:
				get_the_money(arena_scene, arena_scene.p3stats, money_to_get, 2)
			4:
				get_the_money(arena_scene, arena_scene.p4stats, money_to_get, 3)
		await get_tree().create_timer(0.2).timeout
		if hp > 0:
			hp += hp_to_get
			Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(hp_to_get))
		if upgraded:
			await get_tree().create_timer(0.2).timeout
			attack += 1
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, "1")
		setStatText()
		await proc()

func get_the_money(arena_scene, player_stat_array, money_to_gain, coin_index):
	player_stat_array[arena_scene.MONEY] += money_to_gain
	arena_scene.update_text()
	Manager.move_symbol(global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_to_gain))
