extends Card

func item_ability(target_friend):
	await target_friend.buy()
	await target_friend.sell()
