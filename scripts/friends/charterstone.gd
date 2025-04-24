extends Card


func card_specific_rng():
	choices = []
	options = ["coin", "hp4", "hp8", "attack1", "attack2", "x1"]
	for i in range(hp * (x + 2)):
		choices.append(options.pick_random())

func kill(_dead_team, _dead_team_index):
	if not blocked_ability:
		if not upgraded:
			await get_one_random()

func before_attack():
	if not blocked_ability:
		if upgraded:
			await get_one_random()

func get_one_random():
	var arena_scene = get_tree().get_first_node_in_group("arena")
	proc()
	while hp <= 0 and (choices[0] == "hp4" or choices[0] == "hp8"):
		choices.pop_front()
	await get_tree().create_timer(0.35).timeout
	match choices[0]:
		"coin":
			match team_number:
				1:
					get_the_money(arena_scene, arena_scene.p1stats, 2, 0)
				2:
					get_the_money(arena_scene, arena_scene.p2stats, 2, 1)
				3:
					get_the_money(arena_scene, arena_scene.p3stats, 2, 2)
				4:
					get_the_money(arena_scene, arena_scene.p4stats, 2, 3)
		"hp4":
			hp += 6
			Manager.move_symbol(global_position, global_position, most_hp_target_texture, "6")
			setStatText()
		"hp8":
			hp += 10
			Manager.move_symbol(global_position, global_position, most_hp_target_texture, "10")
			setStatText()
		"attack1":
			attack += 1
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, "1")
			setStatText()
		"attack2":
			attack += 2
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, "2")
			setStatText()
		"x1":
			x += 1
			this_x += 1
			Manager.move_symbol(global_position, global_position, x_icon, "")
			setStatText()
	choices.pop_front()
	await proc()

func get_the_money(arena_scene, player_stat_array, money_to_gain, coin_index):
	player_stat_array[arena_scene.MONEY] += money_to_gain
	arena_scene.update_text()
	Manager.move_symbol(global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_to_gain))
