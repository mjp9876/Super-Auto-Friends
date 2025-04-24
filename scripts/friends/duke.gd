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

func end_turn():
	if not blocked_ability and not upgraded:
		Manager.money += 3
		shopScene.updateText()
		await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "3")
		await proc()

func start_turn():
	if not blocked_ability and upgraded:
		Manager.money += 9
		shopScene.updateText()
		await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "9")
		await proc()
