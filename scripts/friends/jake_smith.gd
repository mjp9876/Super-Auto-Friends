extends Card


func enemy_summoned(_enemy):
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var amount = 2
		if upgraded:
			amount = 4
		match team_number:
			1:
				get_the_money(arena_scene, arena_scene.p1stats, amount, 0)
			2:
				get_the_money(arena_scene, arena_scene.p2stats, amount, 1)
			3:
				get_the_money(arena_scene, arena_scene.p3stats, amount, 2)
			4:
				get_the_money(arena_scene, arena_scene.p4stats, amount, 3)
		await proc()

func get_the_money(arena_scene, player_stat_array, money_to_gain, coin_index):
	player_stat_array[arena_scene.MONEY] += money_to_gain
	arena_scene.update_text()
	Manager.move_symbol(global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_to_gain))
