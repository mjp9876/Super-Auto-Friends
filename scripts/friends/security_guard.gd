extends Card


func card_specific_rng():
	options = ["Freddy", "Chica", "Bonnie", "Foxy"]
	if upgraded:
		options = ["Freddy", "Chica", "Bonnie", "Foxy", "Foxy", "Foxy"]
	options.shuffle()
	choice = options[0]

func hurt(_hurter):
	if not blocked_ability and card_name == "Security Guard":
		var image = get_node("image")
		if hp <= 0:
			match choice:
				"Freddy":
					card_name = "Freddy Fazbear"
					hp = 30
					attack = 3
					x = 3
					this_x = 0
					target = targets.CLOCKWISE
					colour = colours.RED
					image.texture = load("res://assets/friends/Freddy Fazbear.png")
					image.scale = Vector2(0.46, 0.46)
				"Chica":
					card_name = "Chica"
					hp = 40
					attack = 2
					x = 2
					this_x = 0
					target = targets.MOST_HP
					colour = colours.YELLOW
					image.texture = load("res://assets/friends/Chica.png")
					image.scale = Vector2(0.46, 0.46)
				"Bonnie":
					card_name = "Bonnie"
					hp = 10
					attack = 4
					x = 4
					this_x = 0
					target = targets.MOST_ATTACK
					colour = colours.BLUE
					image.texture = load("res://assets/friends/Bonnie.png")
					image.scale = Vector2(0.46, 0.46)
				"Foxy":
					card_name = "Foxy"
					hp = 40
					attack = 4
					x = 4
					this_x = 0
					target = targets.MOST_WINS
					colour = colours.RED
					image.texture = load("res://assets/friends/Foxy.png")
					image.scale = Vector2(0.44, 0.44)
			upgradedAbility = ""
			ability = ""
			setStatText()
			setAbilityText()
			setTarget()
			setColour()
			await proc()
			await Manager.card_summoned(team_number, self)
