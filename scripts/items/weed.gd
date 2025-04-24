extends Card


func item_ability(target_friend):
	var start_position = global_position
	target_friend.attack += int(2 * Manager.item_stat_multiplier)
	if target_friend.upgraded:
		target_friend.upgradedAbility = ""
	target_friend.ability = ""
	target_friend.blocked_ability = true
	Manager.move_symbol(start_position, target_friend.global_position, most_attack_target_texture, str(int(2 * Manager.item_stat_multiplier)))
	target_friend.setStatText()
	target_friend.setAbilityText()
