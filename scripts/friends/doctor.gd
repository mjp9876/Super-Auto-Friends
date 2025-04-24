extends Card


func friend_ahead_attacks(friend):
	if not blocked_ability and friend.hp <= 0:
		var hp_to_give = 10
		if upgraded:
			hp_to_give = 30
		friend.hp += hp_to_give
		Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, str(hp_to_give))
		await get_tree().create_timer(0.2).timeout
		await block_ability(self)
		friend.setStatText()
		await proc()

func block_ability(target_card):
	if target_card.upgraded:
		target_card.upgradedAbility = ""
	target_card.ability = ""
	target_card.blocked_ability = true
	Manager.move_symbol(global_position, target_card.global_position, minus_icon, "")
	target_card.setAbilityText()
