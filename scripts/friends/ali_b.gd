extends Card


func hurt(_hurter):
	if not blocked_ability and card_name == "Ali B" and inBattle:
		var image = get_node("image")
		if hp <= 0:
			card_name = "Lee Probert"
			hp = 22
			attack = 10
			x = 1
			if active:
				this_x = 0
			else:
				this_x = x
			target = targets.LEAST_HP
			colour = colours.GREEN
			choice = "not killed"
			ability = "KILL: -1 attack , +1 X"
			upgradedAbility = "KILL: -2 attack , +2 X"
			image.texture = load("res://assets/friends/Lee Probert.png")
			image.scale = Vector2(0.78, 0.78)
			setStatText()
			setAbilityText()
			setTarget()
			setColour()
			await proc()
			await Manager.card_summoned(team_number, self)

func kill(_var1, _var2):
	if not blocked_ability and choice == "not killed":
		pass
	elif not blocked_ability and card_name == "Lee Probert":
		var stat_change = 1
		if upgraded:
			stat_change = 2
		proc()
		attack = max(1, attack - stat_change)
		Manager.move_symbol(global_position, global_position, least_attack_target_texture, str(stat_change))
		await get_tree().create_timer(0.2).timeout
		x += stat_change
		this_x = x
		Manager.move_symbol(global_position, global_position, x_icon, "")
		setStatText()
		await proc()

func before_attack():
	choice = "killed"
