extends Card


func item_ability(_target_friend):
	Manager.money += 12
	Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "12")
	shopScene.updateText()
