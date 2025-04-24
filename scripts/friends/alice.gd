extends Card


func kill(dead_team, dead_team_index):
	if not blocked_ability:
		match dead_team:
			1:
				if Manager.saved_team1[dead_team_index] != null:
					Manager.saved_team1[dead_team_index]["colour"] = colours.RED
			2:
				if Manager.saved_team2[dead_team_index] != null:
					Manager.saved_team2[dead_team_index]["colour"] = colours.RED
			3:
				if Manager.saved_team3[dead_team_index] != null:
					Manager.saved_team3[dead_team_index]["colour"] = colours.RED
			4:
				if Manager.saved_team4[dead_team_index] != null:
					Manager.saved_team4[dead_team_index]["colour"] = colours.RED

func die(_killers):
	if not blocked_ability and inBattle:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var to_be_attacked = []
		var damage_to_deal = 10
		if upgraded:
			damage_to_deal = 20
		if team_number != 1:
			for opponent in arena_scene.p1cards:
				if opponent.card_name != "ghost" and opponent.colour == colours.RED and opponent.hp > 0:
					to_be_attacked.append([opponent, 1])
		if team_number != 2:
			for opponent in arena_scene.p2cards:
				if opponent.card_name != "ghost" and opponent.colour == colours.RED and opponent.hp > 0:
					to_be_attacked.append([opponent, 2])
		if team_number != 3:
			for opponent in arena_scene.p3cards:
				if opponent.card_name != "ghost" and opponent.colour == colours.RED and opponent.hp > 0:
					to_be_attacked.append([opponent, 3])
		if team_number != 4:
			for opponent in arena_scene.p4cards:
				if opponent.card_name != "ghost" and opponent.colour == colours.RED and opponent.hp > 0:
					to_be_attacked.append([opponent, 4])
		if to_be_attacked.size() > 0:
			proc()
		for opponent in to_be_attacked:
			opponent[0].hp -= damage_to_deal
			await Manager.move_symbol(global_position, opponent[0].global_position, attack_icon, str(damage_to_deal))
			await get_tree().create_timer(0.2).timeout
			await opponent[0].hurt(self)
			if opponent[0].hp <= 0:
				match team_number:
					1:
						arena_scene.p1stats[arena_scene.MONEY] += 1
						arena_scene.activate_kill_and_die_stuff(self, opponent[0], opponent[1])
						await Manager.move_symbol(opponent[0].global_position, arena_scene.coin_icons[team_number - 1].global_position, arena_scene.coin_symbol, "")
					2:
						arena_scene.p2stats[arena_scene.MONEY] += 1
						arena_scene.activate_kill_and_die_stuff(self, opponent[0], opponent[1])
						await Manager.move_symbol(opponent[0].global_position, arena_scene.coin_icons[team_number - 1].global_position, arena_scene.coin_symbol, "")
					3:
						arena_scene.p3stats[arena_scene.MONEY] += 1
						arena_scene.activate_kill_and_die_stuff(self, opponent[0], opponent[1])
						await Manager.move_symbol(opponent[0].global_position, arena_scene.coin_icons[team_number - 1].global_position, arena_scene.coin_symbol, "")
					4:
						arena_scene.p4stats[arena_scene.MONEY] += 1
						arena_scene.activate_kill_and_die_stuff(self, opponent[0], opponent[1])
						await Manager.move_symbol(opponent[0].global_position, arena_scene.coin_icons[team_number - 1].global_position, arena_scene.coin_symbol, "")
				match opponent[0].team_number:
					1:
						if arena_scene.p1cards.size() > 1:
							for i in range(1, arena_scene.p1cards.size()):
								arena_scene.card_proc_order_backup.append(arena_scene.p1cards[i])
					2:
						if arena_scene.p2cards.size() > 1:
							for i in range(1, arena_scene.p2cards.size()):
								arena_scene.card_proc_order_backup.append(arena_scene.p2cards[i])
					3:
						if arena_scene.p3cards.size() > 1:
							for i in range(1, arena_scene.p3cards.size()):
								arena_scene.card_proc_order_backup.append(arena_scene.p3cards[i])
					4:
						if arena_scene.p4cards.size() > 1:
							for i in range(1, arena_scene.p4cards.size()):
								arena_scene.card_proc_order_backup.append(arena_scene.p4cards[i])
		if to_be_attacked.size() > 0:
			if to_be_attacked.size() < 4:
				await proc()
			else:
				await get_tree().create_timer(0.3).timeout
