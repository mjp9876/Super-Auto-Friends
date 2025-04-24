extends Card


func start_battle():
	n = 4
	if upgraded:
		n = 8
	setAbilityText()

func after_attack():
	if not blocked_ability:
		n -= 1
		setAbilityText()
		if hp < 0 and n > 0:
			if not upgraded:
				hp = 4
				Manager.move_symbol(global_position, global_position, most_hp_target_texture, "4")
			else:
				hp = 24
				Manager.move_symbol(global_position, global_position, most_hp_target_texture, "24")
			setStatText()
			await proc()
