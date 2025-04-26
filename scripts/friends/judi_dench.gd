extends Card




func start_turn():
	if not blocked_ability:
		if not upgraded:
			attack = rng.randi_range(1,cost)
			setStatText()
		elif upgraded:
			attack = rng.randi_range(1,cost)
			x = rng.randi_range(1,cost)
			setStatText()
	await proc()
