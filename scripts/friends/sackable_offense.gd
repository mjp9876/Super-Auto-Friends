extends Card


func card_specific_rng():
	choices = []
	options = ["1coin", "2coin", "4hp", "8hp", "9attack", "die"]
	if not upgraded:
		options.erase("8hp")
		options.erase("9attack")
	for i in range((hp + 6) * (x + 6)):
		choices.append(options.pick_random())

func hurt(_attacker):
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		while (not inBattle and choices[0] == "die") or (hp <= 0 and choices[0] == "4hp") or (hp <= 0 and choices[0] == "8hp"):
			choices.pop_front()
		await get_tree().create_timer(0.18).timeout
		match choices[0]:
			"1coin":
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
			"2coin":
				if inBattle:
					match team_number:
						1:
							get_the_money(arena_scene, arena_scene.p1stats, 2, 0)
						2:
							get_the_money(arena_scene, arena_scene.p2stats, 2, 1)
						3:
							get_the_money(arena_scene, arena_scene.p3stats, 2, 2)
						4:
							get_the_money(arena_scene, arena_scene.p4stats, 2, 3)
				else:
					Manager.money += 2
					shopScene.updateText()
					await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "2")
			"4hp":
				hp += 4
				Manager.move_symbol(global_position, global_position, most_hp_target_texture, "4")
				setStatText()
			"8hp":
				hp += 8
				Manager.move_symbol(global_position, global_position, most_hp_target_texture, "8")
				setStatText()
			"9attack":
				attack += 9
				Manager.move_symbol(global_position, global_position, most_attack_target_texture, "9")
				setStatText()
			"die":
				hp = 0
				Manager.move_symbol(global_position, global_position, attack_icon, str(hp))
				setStatText()
		choices.pop_front()
		await quick_proc()

func get_the_money(arena_scene, player_stat_array, money_to_gain, coin_index):
	player_stat_array[arena_scene.MONEY] += money_to_gain
	arena_scene.update_text()
	Manager.move_symbol(global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_to_gain))

