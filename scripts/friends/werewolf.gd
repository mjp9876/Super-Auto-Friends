extends Card


func card_specific_rng():
	block_order = range(18)
	block_order.shuffle()

func hurt(attacker):
	if not blocked_ability and not attacker.blocked_ability:
		await block_ability(attacker)
		await quick_proc()

func die(_killers):
	if not blocked_ability and upgraded:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var possible_targets = []
		var cards_to_nerf = 5
		find_possible_targets(arena_scene, possible_targets)
		for i in range(cards_to_nerf):
			if possible_targets.size() > 0 and block_order.size() > 0:
				while possible_targets.size() <= block_order[0]:
					block_order.pop_front()
				proc()
				await block_ability(possible_targets[block_order[0]])
				await get_tree().create_timer(0.15).timeout
				possible_targets.pop_at(block_order[0])
		await proc()

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

func block_ability(target_card):
	if target_card.upgraded:
		target_card.upgradedAbility = ""
	target_card.ability = ""
	target_card.blocked_ability = true
	Manager.move_symbol(global_position, target_card.global_position, minus_icon, "")
	target_card.setAbilityText()
