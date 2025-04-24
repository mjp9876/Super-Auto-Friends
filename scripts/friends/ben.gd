extends Card


func start_battle():
	if not blocked_ability:
		var percentage_damage_to_deal = 0.33
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		var cards_to_nerf = 2
		if upgraded:
			percentage_damage_to_deal = 0.5
			cards_to_nerf = 3
		for i in range(cards_to_nerf):
			find_possible_targets(arena_scene, possible_targets)
			possible_targets.sort_custom(sort_hp)
			if possible_targets.size() > 0:
				proc()
				await reduce_hp(possible_targets[0], percentage_damage_to_deal)
				await get_tree().create_timer(0.2).timeout
				possible_targets.clear()
		await proc()

func sort_hp(a, b):
	if a.hp > b.hp:
		return true
	return false

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

func reduce_hp(opponent, percentage_damage_to_deal):
	opponent.hp -= int(opponent.hp * percentage_damage_to_deal)
	await Manager.move_symbol(global_position, opponent.global_position, least_hp_target_texture, str(percentage_damage_to_deal * 100) + "%")
	await get_tree().create_timer(0.2).timeout
	if opponent.hp <= 0:
		opponent.hp = 1


