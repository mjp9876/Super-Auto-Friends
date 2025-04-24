extends Card


func start_turn():
	if not blocked_ability:
		if upgraded:
			n += 8
		else:
			n += 4
		setAbilityText()

func sell():
	if not blocked_ability:
		await Manager.update_friends()
		var chosen_friend = null
		for i in range(n):
			proc()
			while chosen_friend == null:
				chosen_friend = Manager.friends.pick_random()
			chosen_friend.attack += 1
			Manager.move_symbol(global_position, chosen_friend.global_position, most_attack_target_texture, "1")
			chosen_friend.setStatText()
			chosen_friend = null
			await get_tree().create_timer(0.15).timeout
		await get_tree().create_timer(0.5).timeout
