extends Card


func kill(_dad_team, _dead_team_index):
	if not blocked_ability:
		attack += 2
		Manager.move_symbol(global_position, global_position, most_attack_target_texture, "2")
		setStatText()
		await proc()
