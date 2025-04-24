extends Card


func die(_killers):
	if not blocked_ability and inBattle:
		match team_number:
			1:
				Manager.saved_team1[starting_fighting_slot] = null
			2:
				Manager.saved_team2[starting_fighting_slot] = null
			3:
				Manager.saved_team3[starting_fighting_slot] = null
			4:
				Manager.saved_team4[starting_fighting_slot] = null

func before_attack():
	if not blocked_ability and upgraded:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		find_possible_targets(arena_scene, possible_targets)
		possible_targets.sort_custom(sort_hp)
		if possible_targets.size() > 0:
			proc()
			await attack_opponent(possible_targets[0], 12, arena_scene)
			await proc()

func find_possible_targets(arena_scene, possible_targets):
	if team_number != 1:
		find_opponent(arena_scene.p1cards[0], possible_targets)
	if team_number != 2:
		find_opponent(arena_scene.p2cards[0], possible_targets)
	if team_number != 3:
		find_opponent(arena_scene.p3cards[0], possible_targets)
	if team_number != 4:
		find_opponent(arena_scene.p4cards[0], possible_targets)

func find_opponent(opponent, possible_targets):
	if opponent.card_name != "ghost" and opponent.hp > 0:
		possible_targets.append(opponent)

func sort_hp(a, b):
	if a.hp < b.hp:
		return true
	return false


