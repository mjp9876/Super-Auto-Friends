extends Card


func start_turn():
	if not blocked_ability:
		await get_tree().create_timer(0.2).timeout
		var done_discounts = 0
		var discount_order = [0, 1]
		var need_to_proc = false
		discount_order.shuffle()
		for slot in discount_order:
			if shopScene.item_shop_slots[slot].active and not shopScene.item_shop_slots[slot].card.locked:
				need_to_proc = true
				shopScene.item_shop_slots[slot].card.cost = 0
				shopScene.item_shop_slots[slot].card.setStatText()
				done_discounts += 1
				Manager.move_symbol(global_position, shopScene.item_shop_slots[slot].global_position, coin_icon, "0")
			if done_discounts == 1:
				break
		if need_to_proc:
			await proc()

func kill(dead_team, _dead_team_index):
	if not blocked_ability and upgraded:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var money_to_steal = 3
		match team_number:
				1:
					get_the_money(arena_scene, arena_scene.p1stats, money_to_steal, 0, dead_team)
				2:
					get_the_money(arena_scene, arena_scene.p2stats, money_to_steal, 1, dead_team)
				3:
					get_the_money(arena_scene, arena_scene.p3stats, money_to_steal, 2, dead_team)
				4:
					get_the_money(arena_scene, arena_scene.p4stats, money_to_steal, 3, dead_team)
		await proc()


func get_the_money(arena_scene, player_stat_array, money_to_gain, coin_index, victim_team_number):
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
