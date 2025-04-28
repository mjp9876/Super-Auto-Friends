extends Card


func hurt(hurter):
	if not blocked_ability and card_name == "The Soiled" and inBattle and upgraded:
		var image = get_node("image")
		if hp <= 0:
			card_name = "Giant Poop"
			hp = 20
			attack = 2
			x = 1
			if active:
				this_x = 0
			else:
				this_x = x
			target = targets.LEAST_WINS
			choice = "not died"
			ability = "DIE: Steal 1 coin from the player(s) that killed this, summon a Poop"
			upgradedAbility = "DIE: Steal 1 coin from the player(s) that killed this, summon a Poop"
			image.texture = load("res://assets/friends/Giant Poop.png")
			image.scale = Vector2(0.38, 0.38)
			setStatText()
			setAbilityText()
			setTarget()
			await proc()
			await Manager.card_summoned(team_number, self)
	elif not blocked_ability and inBattle and ((card_name == "The Soiled" and not upgraded) or (card_name == "Giant Poop")):
		var image = get_node("image")
		if hp <= 0:
			card_name = "Poop"
			hp = 10
			attack = 1
			x = 1
			if active:
				this_x = 0
			else:
				this_x = x
			target = targets.LEAST_WINS
			if not upgraded:
				choice = "not died"
			ability = "DIE: Steal 1 coin from the player(s) that killed this"
			upgradedAbility = "DIE: Steal 1 coin from the player(s) that killed this"
			image.texture = load("res://assets/friends/Poop.png")
			image.scale = Vector2(1.04, 1.04)
			setStatText()
			setAbilityText()
			setTarget()
			await proc()
			await Manager.card_summoned(team_number, self)

func die(killers):
	if not blocked_ability and card_name != "The Soiled" and choice == "not died":
		choice = "died"
	elif not blocked_ability and card_name != "The Soiled" and inBattle:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		for killer in killers:
			match team_number:
				1:
					steal_the_money(arena_scene, arena_scene.p1stats, 1, 0, killer.team_number)
				2:
					steal_the_money(arena_scene, arena_scene.p2stats, 1, 1, killer.team_number)
				3:
					steal_the_money(arena_scene, arena_scene.p3stats, 1, 2, killer.team_number)
				4:
					steal_the_money(arena_scene, arena_scene.p4stats, 1, 3, killer.team_number)
		await proc()

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
