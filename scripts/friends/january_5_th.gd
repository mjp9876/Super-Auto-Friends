extends Card


func start_turn():
	if not blocked_ability:
		Manager.update_friends()
		var friends_to_buff = []
		var cutoff = 3
		if upgraded:
			cutoff = 4
		for friend in Manager.friends:
			if friend != null and friend.colour == colours.BLUE and friend != self:
				friends_to_buff.append(friend)
		for friend in friends_to_buff:
			proc()
			if upgraded:
				friend.hp += 5
				Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "5")
				await get_tree().create_timer(0.1).timeout
			friend.attack += 1
			Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, "1")
			await get_tree().create_timer(0.2).timeout
			friend.setStatText()
		if friends_to_buff.size() > 0:
			if friends_to_buff.size() >= cutoff:
				block_ability(self)
			await proc()

func block_ability(target_card):
	if target_card.upgraded:
		target_card.upgradedAbility = ""
	target_card.ability = ""
	target_card.blocked_ability = true
	Manager.move_symbol(global_position, target_card.global_position, minus_icon, "")
	target_card.setAbilityText()
