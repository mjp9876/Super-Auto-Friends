extends Card


func card_specific_rng():
	choice = str(rng.randf())

func die(_killers):
	var cap = 0.5
	if upgraded:
		cap = 0.75
	if not blocked_ability and inBattle and float(choice) > cap:
		match team_number:
			1:
				Manager.saved_team1[starting_fighting_slot] = null
			2:
				Manager.saved_team2[starting_fighting_slot] = null
			3:
				Manager.saved_team3[starting_fighting_slot] = null
			4:
				Manager.saved_team4[starting_fighting_slot] = null

func kill(dead_team, dead_team_index):
	if not blocked_ability:
		match dead_team:
			1:
				if Manager.saved_team1[dead_team_index] != null:
					Manager.saved_team1[dead_team_index]["hp"] = int(max(1, Manager.saved_team1[dead_team_index]["hp"] * 0.5))
					Manager.saved_team1[dead_team_index]["attack"] = int(max(1, Manager.saved_team1[dead_team_index]["attack"] * 0.5))
					Manager.saved_team1[dead_team_index]["x"] = int(max(1, Manager.saved_team1[dead_team_index]["x"] * 0.5))
			2:
				if Manager.saved_team1[dead_team_index] != null:
					Manager.saved_team2[dead_team_index]["hp"] = max(1, Manager.saved_team2[dead_team_index]["hp"] * 0.5)
					Manager.saved_team2[dead_team_index]["attack"] = max(1, Manager.saved_team2[dead_team_index]["attack"] * 0.5)
					Manager.saved_team2[dead_team_index]["x"] = max(1, Manager.saved_team2[dead_team_index]["x"] * 0.5)
			3:
				if Manager.saved_team1[dead_team_index] != null:
					Manager.saved_team3[dead_team_index]["hp"] = max(1, Manager.saved_team3[dead_team_index]["hp"] * 0.5)
					Manager.saved_team3[dead_team_index]["attack"] = max(1, Manager.saved_team3[dead_team_index]["attack"] * 0.5)
					Manager.saved_team3[dead_team_index]["x"] = max(1, Manager.saved_team3[dead_team_index]["x"] * 0.5)
			4:
				if Manager.saved_team1[dead_team_index] != null:
					Manager.saved_team4[dead_team_index]["hp"] = max(1, Manager.saved_team4[dead_team_index]["hp"] * 0.5)
					Manager.saved_team4[dead_team_index]["attack"] = max(1, Manager.saved_team4[dead_team_index]["attack"] * 0.5)
					Manager.saved_team4[dead_team_index]["x"] = max(1, Manager.saved_team4[dead_team_index]["x"] * 0.5)
		await proc()
