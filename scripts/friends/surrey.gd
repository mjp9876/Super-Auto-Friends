extends Card


func friend_dies(_dead_friend_catagory):
	if not blocked_ability and inBattle:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var money_to_get = 1
		if upgraded:
			money_to_get = 2
		match team_number:
			1:
				get_the_money(arena_scene, arena_scene.p1stats, money_to_get, 0)
			2:
				get_the_money(arena_scene, arena_scene.p2stats, money_to_get, 1)
			3:
				get_the_money(arena_scene, arena_scene.p3stats, money_to_get, 2)
			4:
				get_the_money(arena_scene, arena_scene.p4stats, money_to_get, 3)
		await proc()
	elif not blocked_ability and not inBattle:
		var money_to_get = 1
		if upgraded:
			money_to_get = 2
		Manager.money += money_to_get
		shopScene.updateText()
		await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, str(money_to_get))
		await proc()

func get_the_money(arena_scene, player_stat_array, money_to_gain, coin_index):
	player_stat_array[arena_scene.MONEY] += money_to_gain
	arena_scene.update_text()
	Manager.move_symbol(global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_to_gain))
