extends Card


func card_specific_rng():
	choices = ["hp", "attack"]
	choices.shuffle()

func friend_summoned(new_friend):
	if not blocked_ability:
		var hp_to_give = 5
		var attack_to_give = 1
		if upgraded:
			hp_to_give = 10
			attack_to_give = 2
		if not inBattle:
			choices = ["hp", "attack"]
			choices.shuffle()
		match choices[0]:
			"hp":
				new_friend.hp += hp_to_give
				Manager.move_symbol(global_position, new_friend.global_position, most_hp_target_texture, str(hp_to_give))
			"attack":
				new_friend.attack += attack_to_give
				Manager.move_symbol(global_position, new_friend.global_position, most_attack_target_texture, str(attack_to_give))
		new_friend.setStatText()
		await proc()
