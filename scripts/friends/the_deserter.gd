extends Card


func hurt(hurter):
	if not blocked_ability and card_name == "The Deserter" and inBattle:
		var image = get_node("image")
		if hp <= 0:
			card_name = "The Revenant"
			hp = 666
			attack = 66
			x = 6
			if active:
				this_x = 0
			else:
				this_x = x
			n = 0
			target = targets.LEAST_HP
			colour = colours.RED
			choice = "not killed"
			ability = "KILL TWICE: Die"
			upgradedAbility = "KILL THRICE: Die"
			image.texture = load("res://assets/friends/The Revenant.png")
			image.scale = Vector2(1, 1)
			setStatText()
			setAbilityText()
			setTarget()
			setColour()
			await proc()
			await Manager.card_summoned(team_number, self)

func kill(_var1, _var2):
	if not blocked_ability and choice == "not killed":
		pass
	elif not blocked_ability and card_name == "The Revenant":
		n += 1
		var n_limit = 2
		if upgraded:
			n_limit = 3
		if n == n_limit:
			Manager.move_symbol(global_position, global_position, attack_icon, str(hp))
			hp = 0
			setStatText()
			await proc()

func before_attack():
	choice = "killed"
