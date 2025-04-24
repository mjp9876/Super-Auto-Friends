extends Card

func sell():
	if not blocked_ability:
		Manager.money += n
		shopScene.updateText()
		await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, str(n))
		await proc()

func start_turn():
	if not blocked_ability:
		var n_increase = [1, 2, 3, 0]
		if upgraded:
			n_increase = [2, 3, 4, 0]
		n_increase.shuffle()
		if n_increase[0] == 0:
			block_ability(self)
		else:
			n += n_increase[0]
			Manager.move_symbol(global_position, global_position, plus_icon, "")
		setAbilityText()
		await proc()


func block_ability(target_card):
	if target_card.upgraded:
		target_card.upgradedAbility = ""
	target_card.ability = ""
	target_card.blocked_ability = true
	Manager.move_symbol(global_position, target_card.global_position, minus_icon, "")
	target_card.setAbilityText()
