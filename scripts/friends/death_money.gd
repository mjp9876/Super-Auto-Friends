extends Card

var bonus_possibilities = ["hp", "attack", "cost", "target", "colour"]

func friend_uses_item(friend):
	if not blocked_ability and friend != null:
		var bonuses_to_give = 1
		var hp_to_give = 5
		var attack_to_give = 1
		var cost_to_give = 6
		if upgraded:
			bonuses_to_give = 2
			hp_to_give = 7
			attack_to_give = 2
			cost_to_give = 8
		var random_colour = colours.RED
		var random_target = targets.CLOCKWISE
		var random_target_icon
		var random_colour_icon
		proc()
		for i in range(bonuses_to_give):
			await get_tree().create_timer(0.2).timeout
			bonus_possibilities.shuffle()
			match bonus_possibilities[0]:
				"hp":
					friend.hp += hp_to_give
					Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, str(hp_to_give))
					friend.setStatText()
				"attack":
					friend.attack += attack_to_give
					Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, str(attack_to_give))
					friend.setStatText()
				"cost":
					friend.cost += cost_to_give
					Manager.move_symbol(global_position, friend.global_position, coin_icon, "+" + str(cost_to_give))
					friend.setStatText()
				"target":
					random_target = targets.values().pick_random()
					while random_target == friend.target:
						random_target = targets.values().pick_random()
					random_target_icon = find_target_icon(random_target)
					friend.target = random_target
					Manager.move_symbol(global_position, friend.global_position, random_target_icon, "")
					friend.setTarget()
				"colour":
					random_colour = colours.values().pick_random()
					while random_colour == friend.colour or random_colour == colours.ITEM or random_colour == colours.CHANGE:
						random_colour = colours.values().pick_random()
					random_colour_icon = find_colour_icon(random_colour)
					friend.colour = random_colour
					Manager.move_symbol(global_position, friend.global_position, random_colour_icon, "")
					friend.setColour()
		await proc()
