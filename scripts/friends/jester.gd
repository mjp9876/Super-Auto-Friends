extends Card


func hurt(_hurter):
	if not blocked_ability and card_name == "Jester":
		var image = get_node("image")
		if hp <= 0:
			card_name = "Vengeful Spirit"
			hp = 1
			attack = 5
			x = 1
			if active:
				this_x = 0
			else:
				this_x = x
			target = targets.MOST_WINS
			choice = "not died"
			upgradedAbility = "DIE: Kill all active cards"
			ability = "DIE: Kill the card(s) that killed this"
			image.texture = load("res://assets/friends/Jester Ghost.png")
			image.scale = Vector2(0.56,0.56)
			setStatText()
			setAbilityText()
			setTarget()
			await proc()
			await Manager.card_summoned(team_number, self)

func die(killers):
	if not blocked_ability and card_name == "Vengeful Spirit" and choice == "not died":
		choice = "died"
	elif not blocked_ability and inBattle and card_name == "Vengeful Spirit":
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		if not upgraded:
			await kill_cards(killers, arena_scene)
		else:
			find_possible_targets(arena_scene, possible_targets)
			await kill_cards(possible_targets, arena_scene)

func kill_cards(cards_to_kill, arena_scene):
	var need_to_proc = false
	var damage_to_deal
	for i in range(cards_to_kill.size()):
		if cards_to_kill[i].hp > 0:
			proc()
			need_to_proc = true
			damage_to_deal = cards_to_kill[i].hp
			await attack_opponent(cards_to_kill[i], damage_to_deal, arena_scene)
	if need_to_proc:
		await proc()

func find_possible_targets(arena_scene, possible_targets):
	if arena_scene.p1cards[0].card_name != "ghost" and arena_scene.p1cards[0].hp > 0:
		possible_targets.append(arena_scene.p1cards[0])
	if arena_scene.p2cards[0].card_name != "ghost" and arena_scene.p2cards[0].hp > 0:
		possible_targets.append(arena_scene.p2cards[0])
	if arena_scene.p3cards[0].card_name != "ghost" and arena_scene.p3cards[0].hp > 0:
		possible_targets.append(arena_scene.p3cards[0])
	if arena_scene.p4cards[0].card_name != "ghost" and arena_scene.p4cards[0].hp > 0:
		possible_targets.append(arena_scene.p4cards[0])
