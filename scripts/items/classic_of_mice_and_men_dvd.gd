extends Card


func item_ability(target_friend):
	target_friend.swapATKandX += 1
	var tempATK = target_friend.attack
	target_friend.attack = target_friend.x
	target_friend.x = tempATK
	target_friend.setStatText()
