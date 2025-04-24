extends Card


func card_specific_rng():
	choices = []
	options = ["coin", "hp", "attack opponent", "gain attack"]
	attack_order = []
	attack_order_possibilities = range(18)
	for i in range((hp + 6) * (x + 6)):
		choices.append(options.pick_random())
		attack_order.append(attack_order_possibilities.pick_random())

func hurt(_attacker):
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		while (not inBattle and choices[0] == "attack opponent") or (hp <= 0 and choices[0] == "hp"):
			choices.pop_front()
		if not upgraded:
			while (choices[0] == "gain attack") or (not inBattle and choices[0] == "attack opponent") or (hp <= 0 and choices[0] == "hp"):
				choices.pop_front()
			await get_tree().create_timer(0.18).timeout
			match choices[0]:
				"coin":
					if inBattle:
						match team_number:
							1:
								get_the_money(arena_scene, arena_scene.p1stats, 1, 0)
							2:
								get_the_money(arena_scene, arena_scene.p2stats, 1, 1)
							3:
								get_the_money(arena_scene, arena_scene.p3stats, 1, 2)
							4:
								get_the_money(arena_scene, arena_scene.p4stats, 1, 3)
					else:
						Manager.money += 1
						shopScene.updateText()
						await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "1")
				"hp":
					hp += 6
					Manager.move_symbol(global_position, global_position, most_hp_target_texture, "6")
					setStatText()
				"attack opponent":
					find_possible_targets(arena_scene, possible_targets)
					if possible_targets.size() > 0:
						while possible_targets.size() <= attack_order[0]:
							attack_order.pop_front()
						proc()
						await attack_opponent(possible_targets[attack_order[0]], 4, arena_scene)
						await get_tree().create_timer(0.2).timeout
						attack_order.pop_front()
						possible_targets.clear()
			choices.pop_front()
			await quick_proc()
		else:
			await get_tree().create_timer(0.18).timeout
			match choices[0]:
				"coin":
					if inBattle:
						match team_number:
							1:
								get_the_money(arena_scene, arena_scene.p1stats, 1, 0)
							2:
								get_the_money(arena_scene, arena_scene.p2stats, 1, 1)
							3:
								get_the_money(arena_scene, arena_scene.p3stats, 1, 2)
							4:
								get_the_money(arena_scene, arena_scene.p4stats, 1, 3)
					else:
						Manager.money += 1
						shopScene.updateText()
						await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "1")
				"hp":
					hp += 8
					Manager.move_symbol(global_position, global_position, most_hp_target_texture, "8")
					setStatText()
				"attack opponent":
					find_possible_targets(arena_scene, possible_targets)
					possible_targets.shuffle()
					if possible_targets.size() > 0:
						while possible_targets.size() <= attack_order[0]:
							attack_order.pop_front()
						proc()
						await attack_opponent(possible_targets[attack_order[0]], 8, arena_scene)
						await get_tree().create_timer(0.2).timeout
						attack_order.pop_front()
						possible_targets.clear()
				"gain attack":
					attack += 1
					Manager.move_symbol(global_position, global_position, most_attack_target_texture, "1")
					setStatText()
			choices.pop_front()
			await quick_proc()

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
