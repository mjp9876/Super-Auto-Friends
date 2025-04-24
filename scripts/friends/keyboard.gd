extends Card


func kill(_dead_team, _dead_team_index):
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		if n > 0:
			match team_number:
				1:
					get_the_money(arena_scene, arena_scene.p1stats, n, 0)
				2:
					get_the_money(arena_scene, arena_scene.p2stats, n, 1)
				3:
					get_the_money(arena_scene, arena_scene.p3stats, n, 2)
				4:
					get_the_money(arena_scene, arena_scene.p4stats, n, 3)
			await proc()

func get_the_money(arena_scene, player_stat_array, money_to_gain, coin_index):
	player_stat_array[arena_scene.MONEY] += money_to_gain
	arena_scene.update_text()
	Manager.move_symbol(global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_to_gain))

func start_turn():
	if not blocked_ability:
		var n_cap = 4
		if upgraded:
			n_cap = 6
		if n < n_cap:
			n += 1
			Manager.move_symbol(global_position, global_position, plus_icon, "")
			setAbilityText()
			await proc()
