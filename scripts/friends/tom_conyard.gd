extends Card


func friend_summoned(friend):
	if not blocked_ability:
		var attack_to_give = 1
		if upgraded:
			attack_to_give = 2
		friend.attack += attack_to_give
		Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, str(attack_to_give))
		friend.setStatText()
		await proc()

func enemy_summoned(enemy):
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		var damage_to_deal = 12
		if upgraded:
			damage_to_deal = 20
		proc()
		await attack_opponent(enemy, damage_to_deal, arena_scene)
		await proc()
