extends Card


func card_specific_rng():
	choices = []
	for i in range(100):
		choices.append(rng.randf())

func hurt(hurter):
	if not blocked_ability and card_name == "The Enigma" and inBattle:
		var cap = 0.5
		if upgraded:
			cap = 0.25
		if choices[0] > cap and hp <= 0:
			choices.pop_front()
			var image = get_node("image")
			card_name = "amginE ehT"
			hp = 25
			x = 5
			if active:
				this_x = 0
			else:
				this_x = x
			target = targets.RANDOM
			colour = colours.RED
			ability = "SUMMONED: Copy attack of The Enigma\nDIE: 50% chance to summon The Enigma"
			upgradedAbility = "SUMMONED: Copy attack of The Enigma\nDIE: 75% chance to summon The Enigma+"
			image.texture = load("res://assets/friends/amginE ehT.png")
			setStatText()
			setAbilityText()
			setTarget()
			setColour()
			await proc()
			await Manager.card_summoned(team_number, self)
	if not blocked_ability and card_name == "amginE ehT" and inBattle:
		var cap = 0.5
		if upgraded:
			cap = 0.25
		if choices[0] > cap and hp <= 0:
			choices.pop_front()
			var image = get_node("image")
			card_name = "The Enigma"
			hp = 15
			x = 1
			if active:
				this_x = 0
			else:
				this_x = x
			target = targets.CLOCKWISE
			colour = colours.RED
			ability = "DIE IN BATTLE: 50% chance to summon amginE ehT"
			upgradedAbility = "DIE IN BATTLE: 75% chance to summon amginE ehT+"
			image.texture = load("res://assets/friends/The Enigma.png")
			setStatText()
			setAbilityText()
			setTarget()
			setColour()
			await proc()
			await Manager.card_summoned(team_number, self)
