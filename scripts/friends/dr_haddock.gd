extends Card


func start_battle():
	if not blocked_ability and team_number not in Manager.previous_round_winner:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		var cards_to_nerf_per_team = 2
		if upgraded:
			cards_to_nerf_per_team = 3
		find_possible_targets(arena_scene, possible_targets, cards_to_nerf_per_team)
		for card in possible_targets:
			proc()
			await block_ability(card)
			await get_tree().create_timer(0.15).timeout
		await proc()

func sort_hp(a, b):
	if a.hp > b.hp:
		return true
	return false

func find_possible_targets(arena_scene, possible_targets, cards_to_nerf_per_team):
	var this_team = []
	if team_number != 1:
		for opponent in arena_scene.p1cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				this_team.append(opponent)
		find_highest_hp(this_team, cards_to_nerf_per_team, possible_targets)
	if team_number != 2:
		for opponent in arena_scene.p2cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				this_team.append(opponent)
		find_highest_hp(this_team, cards_to_nerf_per_team, possible_targets)
	if team_number != 3:
		for opponent in arena_scene.p3cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				this_team.append(opponent)
		find_highest_hp(this_team, cards_to_nerf_per_team, possible_targets)
	if team_number != 4:
		for opponent in arena_scene.p4cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				this_team.append(opponent)
		find_highest_hp(this_team, cards_to_nerf_per_team, possible_targets)

func find_highest_hp(this_team, cards_to_nerf_per_team, possible_targets):
	this_team.sort_custom(sort_hp)
	for i in range(cards_to_nerf_per_team):
		if this_team[0] != null:
			possible_targets.append(this_team[0])
			this_team.pop_front()
	this_team.clear()

func block_ability(target_card):
	if target_card.upgraded:
		target_card.upgradedAbility = ""
	target_card.ability = ""
	target_card.blocked_ability = true
	Manager.move_symbol(global_position, target_card.global_position, minus_icon, "")
	target_card.setAbilityText()

