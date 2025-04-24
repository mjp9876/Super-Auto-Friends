extends Card


func reroll():
	if not blocked_ability:
		var tabletop_friends_in_team = 0
		Manager.update_friends()
		for friend in Manager.friends:
			if friend != null and friend.catagory == catagories.TABLETOP_GAMES:
				tabletop_friends_in_team += 1
		if tabletop_friends_in_team > 1:
			proc()
			await get_tree().create_timer(0.2).timeout
			Manager.money += tabletop_friends_in_team
			shopScene.updateText()
			await Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, str(tabletop_friends_in_team))
			await proc()

func friend_uses_item(_friend_using_item):
	if not blocked_ability and upgraded:
		Manager.move_symbol(global_position, global_position, reroll_icon, "")
		proc()
		await shopScene.free_reroll()
		await Manager.rerolled()
