extends Card


func hurt(hurter):
	var muppets = ["Beaker", "Fozzie Bear", "Gonzo the Great", "The Swedish Chef", "Kermit The Frog", "Miss Piggy", "Animal"]
	if not blocked_ability and hp > 0 and card_name == "Tom Mummert":
		n = min(n + 1, 6)
		ability = "HURT: Summon a better muppet on death\nDIE IN BATTLE: Summon " + muppets[n]
		upgradedAbility = "HURT: Summon a better muppet on death\nDIE IN BATTLE: Summon " + muppets[n] + "+"
		if n == 6:
			ability = "DIE IN BATTLE: Summon Animal"
			upgradedAbility = "DIE IN BATTLE: Summon Animal+"
		setAbilityText()
	if not blocked_ability and card_name == "Tom Mummert" and inBattle and hp <= 0:
		match muppets[n]:
			"Beaker":
				var image = get_node("image")
				card_name = "Beaker"
				hp = 15
				attack = 5
				x = 1
				if active:
					this_x = 0
				else:
					this_x = x
				target = targets.LEAST_WINS
				colour = colours.YELLOW
				choice = "not ready"
				ability = "AFTER ATTACK: -3 attack (Minimum 1)"
				upgradedAbility = "AFTER ATTACK: -1 attack (Minimum 1)"
				image.texture = load("res://assets/friends/Beaker.png")
				image.scale = Vector2(0.48, 0.48)
				setStatText()
				setAbilityText()
				setTarget()
				setColour()
				await proc()
				await Manager.card_summoned(team_number, self)
			"Fozzie Bear":
				var image = get_node("image")
				card_name = "Fozzie Bear"
				hp = 28
				attack = 2
				x = 3
				if active:
					this_x = 0
				else:
					this_x = x
				target = targets.CLOCKWISE
				colour = colours.YELLOW
				choice = "not ready"
				ability = "AFTER ATTACK: +4 hp"
				upgradedAbility = "AFTER ATTACK: +6 hp"
				image.texture = load("res://assets/friends/Fozzie Bear.png")
				image.scale = Vector2(0.49, 0.49)
				setStatText()
				setAbilityText()
				setTarget()
				setColour()
				await proc()
				await Manager.card_summoned(team_number, self)
			"Gonzo the Great":
				var image = get_node("image")
				card_name = "Gonzo the Great"
				hp = 45
				attack = 1
				x = 1
				if active:
					this_x = 0
				else:
					this_x = x
				target = targets.MOST_ATTACK
				colour = colours.BLUE
				ability = "HURT: Set attack to 1/3 of hp"
				upgradedAbility = "HURT: Set attack to 2/3 of hp"
				image.texture = load("res://assets/friends/Gonzo The Great.png")
				image.scale = Vector2(0.48, 0.48)
				setStatText()
				setAbilityText()
				setTarget()
				setColour()
				await proc()
				await Manager.card_summoned(team_number, self)
			"The Swedish Chef":
				var image = get_node("image")
				card_name = "The Swedish Chef"
				hp = 55
				attack = 5
				x = 3
				if active:
					this_x = 0
				else:
					this_x = x
				target = targets.CLOCKWISE
				colour = colours.BLUE
				ability = "BEFORE ATTACK: Give all friends in your team +3 hp"
				upgradedAbility = "BEFORE ATTACK: Give all friends in your team +6 hp"
				image.texture = load("res://assets/friends/Swedish Chef.png")
				image.scale = Vector2(0.48, 0.48)
				setStatText()
				setAbilityText()
				setTarget()
				setColour()
				await proc()
				await Manager.card_summoned(team_number, self)
			"Kermit The Frog":
				var image = get_node("image")
				card_name = "Kermit The Frog"
				hp = 65
				attack = 4
				x = 4
				if active:
					this_x = 0
				else:
					this_x = x
				target = targets.MOST_WINS
				colour = colours.GREEN
				choice = "not ready"
				ability = "DIE: Give all friends in your team +15 hp , +3 attack"
				upgradedAbility = "DIE: Give all friends in your team +25 hp , +5 attack , +1 X"
				image.texture = load("res://assets/friends/Kermit The Frog.png")
				image.scale = Vector2(0.48, 0.48)
				setStatText()
				setAbilityText()
				setTarget()
				setColour()
				await proc()
				await Manager.card_summoned(team_number, self)
			"Miss Piggy":
				var image = get_node("image")
				card_name = "Miss Piggy"
				hp = 75
				attack = 20
				if upgraded:
					attack = 35
				x = 1
				if active:
					this_x = 0
				else:
					this_x = x
				target = targets.RANDOM
				colour = colours.RED
				ability = "HURT: Deal 20 attack to the card that hurt this"
				upgradedAbility = "HURT: Deal 20 attack to the card that hurt this"
				image.texture = load("res://assets/friends/Miss Piggy.png")
				image.scale = Vector2(0.47, 0.47)
				setStatText()
				setAbilityText()
				setTarget()
				setColour()
				await proc()
				await Manager.card_summoned(team_number, self)
			"Animal":
				var image = get_node("image")
				card_name = "Animal"
				hp = 100
				attack = 17
				x = 6
				if upgraded:
					hp = 150
					attack = 23
					x = 9
				if active:
					this_x = 0
				else:
					this_x = x
				target = targets.RANDOM
				colour = colours.RED
				ability = ""
				upgradedAbility = ""
				image.texture = load("res://assets/friends/Animal.png")
				image.scale = Vector2(0.45, 0.45)
				setStatText()
				setAbilityText()
				setTarget()
				setColour()
				await proc()
				await Manager.card_summoned(team_number, self)
	elif not blocked_ability and card_name == "Gonzo the Great":
		var hp_multiplier = 0.33
		if upgraded:
			hp_multiplier = 0.67
		var attack_change = int(max(1, hp * hp_multiplier) - attack)
		attack = int(max(1, hp * hp_multiplier))
		setStatText()
		if attack_change > 0:
			Manager.move_symbol(global_position, global_position, most_attack_target_texture, str(attack_change))
			await proc()
		elif attack_change < 0:
			Manager.move_symbol(global_position, global_position, least_attack_target_texture, str(-attack_change))
			await proc()
	elif not blocked_ability and card_name == "Miss Piggy" and hurter.hp > 0:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var damage_to_deal = 20
		if upgraded:
			damage_to_deal = 35
		proc()
		await attack_opponent(hurter, damage_to_deal, arena_scene)
		await proc()

func before_attack():
	if card_name == "Beaker" or card_name == "Fozzie Bear" or card_name == "Kermit The Frog":
		choice = "ready"
	elif not blocked_ability and card_name == "The Swedish Chef":
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var cards_to_buff = []
		var hp_to_give = 3
		if upgraded:
			hp_to_give = 6
		find_team_mates(arena_scene, cards_to_buff)
		for friend in cards_to_buff:
			proc()
			friend.hp += hp_to_give
			Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, str(hp_to_give))
			await get_tree().create_timer(0.1).timeout
			friend.setStatText()
		await proc()

func after_attack():
	if not blocked_ability and card_name == "Beaker" and choice == "ready":
		var attack_to_lose = 3
		if upgraded:
			attack_to_lose = 1
		attack = max(1, attack - attack_to_lose)
		Manager.move_symbol(global_position, global_position, least_attack_target_texture, str(attack_to_lose))
		setStatText()
		await proc()
	if not blocked_ability and card_name == "Fozzie Bear" and choice == "ready" and hp > 0:
		var hp_to_gain = 4
		if upgraded:
			hp_to_gain = 6
		hp += hp_to_gain
		Manager.move_symbol(global_position, global_position, most_hp_target_texture, str(hp_to_gain))
		setStatText()
		await proc()

func die(_killers):
	if not blocked_ability and card_name == "Kermit The Frog" and choice == "ready":
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var cards_to_buff = []
		var hp_to_give = 15
		var attack_to_give = 3
		if upgraded:
			hp_to_give = 25
			attack_to_give = 5
		find_team_mates(arena_scene, cards_to_buff)
		for friend in cards_to_buff:
			proc()
			friend.hp += hp_to_give
			Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, str(hp_to_give))
			await get_tree().create_timer(0.1).timeout
			friend.attack += attack_to_give
			Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, str(attack_to_give))
			await get_tree().create_timer(0.1).timeout
			if upgraded:
				friend.x += 1
				friend.this_x = friend.x
				Manager.move_symbol(global_position, friend.global_position, x_icon, "")
				await get_tree().create_timer(0.1).timeout
		await proc()

func find_team_mates(arena_scene, possible_targets):
	if team_number == 1:
		for opponent in arena_scene.p1cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)
	if team_number == 2:
		for opponent in arena_scene.p2cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)
	if team_number == 3:
		for opponent in arena_scene.p3cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)
	if team_number == 4:
		for opponent in arena_scene.p4cards:
			if opponent.card_name != "ghost" and opponent.hp > 0:
				possible_targets.append(opponent)
