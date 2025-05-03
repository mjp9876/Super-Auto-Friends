extends Card


func card_specific_rng():
	choice = str(rng.randf())

func hurt(hurter):
	if not blocked_ability and card_name == "Captain Toad" and inBattle:
		var cap = 0.67
		if upgraded:
			cap = 0.34
		if float(choice) > cap:
			var image = get_node("image")
			if hp <= 0:
				card_name = "Treasure"
				hp = 25
				if upgraded:
					hp = 45
				attack = 1
				x = 1
				if active:
					this_x = 0
				else:
					this_x = x
				target = targets.LEAST_HP
				colour = colours.YELLOW
				ability = "HURT: +1 coin , give the player that hurt this +1 coin"
				upgradedAbility = "HURT: +1 coin , give the player that hurt this +1 coin"
				image.texture = load("res://assets/friends/Treasure.png")
				image.scale = Vector2(0.42,0.42)
				setStatText()
				setAbilityText()
				setTarget()
				setColour()
				await proc()
				await Manager.card_summoned(team_number, self)
	elif not blocked_ability and card_name == "Treasure":
		var arena_scene = get_tree().get_first_node_in_group("arena")
		match team_number:
			1:
				get_the_money(arena_scene, arena_scene.p1stats, 1, 0)
			2:
				get_the_money(arena_scene, arena_scene.p2stats, 1, 1)
			3:
				get_the_money(arena_scene, arena_scene.p3stats, 1, 2)
			4:
				get_the_money(arena_scene, arena_scene.p4stats, 1, 3)
		match hurter.team_number:
			1:
				get_the_money(arena_scene, arena_scene.p1stats, 1, 0)
			2:
				get_the_money(arena_scene, arena_scene.p2stats, 1, 1)
			3:
				get_the_money(arena_scene, arena_scene.p3stats, 1, 2)
			4:
				get_the_money(arena_scene, arena_scene.p4stats, 1, 3)
		await quick_proc()

func get_the_money(arena_scene, player_stat_array, money_to_gain, coin_index):
	player_stat_array[arena_scene.MONEY] += money_to_gain
	arena_scene.update_text()
	Manager.move_symbol(global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(money_to_gain))
