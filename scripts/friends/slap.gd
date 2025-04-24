extends Card


func die(_killers):
	if not blocked_ability and inBattle:
		match team_number:
			1:
				Manager.saved_team1[starting_fighting_slot] = null
			2:
				Manager.saved_team2[starting_fighting_slot] = null
			3:
				Manager.saved_team3[starting_fighting_slot] = null
			4:
				Manager.saved_team4[starting_fighting_slot] = null

func kill(_dad_team, _dead_team_index):
	if not blocked_ability and upgraded:
		block_ability(self)
		await proc()

func block_ability(target_card):
	if target_card.upgraded:
		target_card.upgradedAbility = ""
	target_card.ability = ""
	target_card.blocked_ability = true
	Manager.move_symbol(global_position, target_card.global_position, minus_icon, "")
	target_card.setAbilityText()
