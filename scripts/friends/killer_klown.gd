extends Card


func kill(_dead_team, _dead_team_index):
	if not blocked_ability and inBattle:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		var damage_to_deal_to_friend = 2
		var damage_to_deal_to_opponents = 10
		var friend_behind
		var need_to_proc = false
		if upgraded:
			damage_to_deal_to_friend = 1
			damage_to_deal_to_opponents = 18
		match team_number:
			1:
				friend_behind = find_friend_behind(arena_scene.p1cards)
			2:
				friend_behind = find_friend_behind(arena_scene.p2cards)
			3:
				friend_behind = find_friend_behind(arena_scene.p3cards)
			4:
				friend_behind = find_friend_behind(arena_scene.p4cards)
		if friend_behind != null:
			proc()
			need_to_proc = true
			await attack_opponent(friend_behind, damage_to_deal_to_friend, arena_scene)
			await get_tree().create_timer(0.2).timeout
		find_possible_targets(arena_scene, possible_targets)
		need_to_proc = await attack_cards(possible_targets, arena_scene, damage_to_deal_to_opponents, need_to_proc)
		if need_to_proc:
			await proc()

func attack_cards(cards_to_attack, arena_scene, damage_to_deal, need_to_proc):
	for i in range(cards_to_attack.size()):
		if cards_to_attack[i].hp > 0:
			need_to_proc = true
			proc()
			await attack_opponent(cards_to_attack[i], damage_to_deal, arena_scene)
	return need_to_proc

func find_possible_targets(arena_scene, possible_targets):
	if team_number != 1:
		if arena_scene.p1cards[0].card_name != "ghost" and arena_scene.p1cards[0].hp > 0:
			possible_targets.append(arena_scene.p1cards[0])
	if team_number != 2:
		if arena_scene.p2cards[0].card_name != "ghost" and arena_scene.p2cards[0].hp > 0:
			possible_targets.append(arena_scene.p2cards[0])
	if team_number != 3:
		if arena_scene.p3cards[0].card_name != "ghost" and arena_scene.p3cards[0].hp > 0:
			possible_targets.append(arena_scene.p3cards[0])
	if team_number != 4:
		if arena_scene.p4cards[0].card_name != "ghost" and arena_scene.p4cards[0].hp > 0:
			possible_targets.append(arena_scene.p4cards[0])

func find_friend_behind(team):
	var search_position
	var slot_position
	var found_friend = null
	slot_position = team.find(self)
	search_position = slot_position + 1
	while search_position <= team.size() - 1:
		if team[search_position] == null or team[search_position].hp <= 0:
			search_position += 1
		else:
			found_friend = team[search_position]
			break
	return found_friend
