extends Card

func hurt(_attacker):
	if not blocked_ability:
		await get_money(1)
		await quick_proc()

func die(_killers):
	if not blocked_ability and upgraded:
		await get_money(3)
		await quick_proc()

func get_money(amount):
	if inBattle:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		match team_number:
			1:
				get_the_money(arena_scene, arena_scene.p1stats, amount, 0)
			2:
				get_the_money(arena_scene, arena_scene.p2stats, amount, 1)
			3:
				get_the_money(arena_scene, arena_scene.p3stats, amount, 2)
			4:
				get_the_money(arena_scene, arena_scene.p4stats, amount, 3)
	else:
		Manager.money += amount
		shopScene.updateText()
		await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, str(amount))

func get_the_money(arena_scene, player_stat_array, money_to_gain, coin_index):
	player_stat_array[arena_scene.MONEY] += money_to_gain
	arena_scene.update_text()
	Manager.move_symbol(global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_to_gain))

