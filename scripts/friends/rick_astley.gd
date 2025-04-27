extends Card


func card_specific_rng():
	choice = str(rng.randf())

func hurt(hurter):
	if not blocked_ability and card_name == "Rick Astley":
		var cap = 0.5
		if upgraded:
			cap = 0.25
		if float(choice) > cap:
			var image = get_node("image")
			if hp <= 0:
				card_name = "Rickroll"
				hp = 35
				attack = 2
				x = 4
				this_x = 0
				target = targets.MOST_HP
				colour = colours.RED
				ability = "HURT: Remove 40% hp from the card that hurt this"
				upgradedAbility = "HURT: Remove 60% hp from the card that hurt this"
				image.texture = load("res://assets/friends/Rickroll.png")
				image.scale = Vector2(0.6,0.6)
				setStatText()
				setAbilityText()
				setTarget()
				setColour()
				await proc()
				await Manager.card_summoned(team_number, self)
	elif not blocked_ability and card_name == "Rickroll" and hurter.hp > 1:
		var hp_to_reduce = 0.4
		if upgraded:
			hp_to_reduce = 0.6
		quick_proc()
		await reduce_hp(hurter, hp_to_reduce)
		await quick_proc()

func reduce_hp(opponent, percentage_damage_to_deal):
	opponent.hp -= int(opponent.hp * percentage_damage_to_deal)
	await Manager.move_symbol(global_position, opponent.global_position, least_hp_target_texture, str(percentage_damage_to_deal * 100) + "%")
	await get_tree().create_timer(0.2).timeout
	if opponent.hp <= 0:
		opponent.hp = 1
