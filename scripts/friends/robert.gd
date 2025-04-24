extends Card


func kill(dead_team, _dead_team_index):
	var arena_scene = get_tree().get_first_node_in_group("arena")
	if not blocked_ability and upgraded:
		var money_to_steal = 5
		match team_number:
				1:
					steal_the_money(arena_scene, arena_scene.p1stats, money_to_steal, 0, dead_team)
				2:
					steal_the_money(arena_scene, arena_scene.p2stats, money_to_steal, 1, dead_team)
				3:
					steal_the_money(arena_scene, arena_scene.p3stats, money_to_steal, 2, dead_team)
				4:
					steal_the_money(arena_scene, arena_scene.p4stats, money_to_steal, 3, dead_team)
		await proc()
	elif not blocked_ability and not upgraded:
		match team_number:
			1:
				get_the_money(arena_scene, arena_scene.p1stats, 5, 0)
			2:
				get_the_money(arena_scene, arena_scene.p2stats, 5, 1)
			3:
				get_the_money(arena_scene, arena_scene.p3stats, 5, 2)
			4:
				get_the_money(arena_scene, arena_scene.p4stats, 5, 3)
		await proc()

func get_the_money(arena_scene, player_stat_array, money_to_gain, coin_index):
	player_stat_array[arena_scene.MONEY] += money_to_gain
	arena_scene.update_text()
	Manager.move_symbol(global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_to_gain))


func steal_the_money(arena_scene, player_stat_array, money_to_gain, coin_index, victim_team_number):
	var money_stolen = 0
	match victim_team_number:
		1:
			money_stolen = min(money_to_gain, arena_scene.p1stats[arena_scene.MONEY])
			arena_scene.p1stats[arena_scene.MONEY] = max(0, arena_scene.p1stats[arena_scene.MONEY] - money_to_gain)
			Manager.move_symbol(arena_scene.coin_icons[0].global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_stolen))
		2:
			money_stolen = min(money_to_gain, arena_scene.p2stats[arena_scene.MONEY])
			arena_scene.p2stats[arena_scene.MONEY] = max(0, arena_scene.p2stats[arena_scene.MONEY] - money_to_gain)
			Manager.move_symbol(arena_scene.coin_icons[1].global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_stolen))
		3:
			money_stolen = min(money_to_gain, arena_scene.p3stats[arena_scene.MONEY])
			arena_scene.p3stats[arena_scene.MONEY] = max(0, arena_scene.p3stats[arena_scene.MONEY] - money_to_gain)
			Manager.move_symbol(arena_scene.coin_icons[2].global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_stolen))
		4:
			money_stolen = min(money_to_gain, arena_scene.p4stats[arena_scene.MONEY])
			arena_scene.p4stats[arena_scene.MONEY] = max(0, arena_scene.p4stats[arena_scene.MONEY] - money_to_gain)
			Manager.move_symbol(arena_scene.coin_icons[3].global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_stolen))
	player_stat_array[arena_scene.MONEY] += money_stolen
	arena_scene.update_text()
