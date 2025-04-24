extends Card


func card_specific_rng():
	possible_index = [0, 1, 2, 3, 4]
	possible_index.shuffle()


func start_battle():
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var cards_to_buff = []
		var done_buffs = 0
		find_possible_targets(arena_scene, cards_to_buff)
		for i in range(5):
			if cards_to_buff.size() > possible_index[i]:
				proc()
				cards_to_buff[possible_index[i]].hp = max(1, cards_to_buff[possible_index[i]].hp - 3)
				Manager.move_symbol(global_position, cards_to_buff[possible_index[i]].global_position, least_hp_target_texture, "3")
				await get_tree().create_timer(0.1).timeout
				cards_to_buff[possible_index[i]].attack += 2
				Manager.move_symbol(global_position, cards_to_buff[possible_index[i]].global_position, most_attack_target_texture, "2")
				await get_tree().create_timer(0.1).timeout
				cards_to_buff[possible_index[i]].setStatText()
				done_buffs += 1
			if done_buffs >= 3 and not upgraded:
				break
		await proc()

func find_possible_targets(arena_scene, possible_targets):
	match team_number:
		1:
			for opponent in arena_scene.p1cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent != self:
					possible_targets.append(opponent)
		2:
			for opponent in arena_scene.p2cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent != self:
					possible_targets.append(opponent)
		3:
			for opponent in arena_scene.p3cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent != self:
					possible_targets.append(opponent)
		4:
			for opponent in arena_scene.p4cards:
				if opponent.card_name != "ghost" and opponent.hp > 0 and opponent != self:
					possible_targets.append(opponent)
