extends Card


func die(_killers):
	if not blocked_ability and inBattle:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		match team_number:
			1:
				Manager.saved_team1[starting_fighting_slot] = null
				get_the_money(arena_scene, arena_scene.p1stats, -8, 0)
			2:
				Manager.saved_team2[starting_fighting_slot] = null
				get_the_money(arena_scene, arena_scene.p2stats, -8, 1)
			3:
				Manager.saved_team3[starting_fighting_slot] = null
				get_the_money(arena_scene, arena_scene.p3stats, -8, 2)
			4:
				Manager.saved_team4[starting_fighting_slot] = null
				get_the_money(arena_scene, arena_scene.p4stats, -8, 3)
		await proc()
	if not blocked_ability and not inBattle:
		Manager.money = max(0, Manager.money - 8)
		shopScene.updateText()
		await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "-8")
		await proc()

func buy():
	if not blocked_ability:
		var money_to_get = 10
		if upgraded:
			money_to_get = 16
		Manager.money += money_to_get
		shopScene.updateText()
		await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, str(money_to_get))
		await proc()

func get_the_money(arena_scene, player_stat_array, money_to_gain, coin_index):
	player_stat_array[arena_scene.MONEY] += money_to_gain
	arena_scene.update_text()
	Manager.move_symbol(global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_to_gain))
