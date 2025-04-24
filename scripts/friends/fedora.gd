extends Card


func end_turn():
	if not blocked_ability:
		var target_friends = []
		var options = ["hp", "attack"]
		Manager.update_friends()
		for friend in Manager.friends:
			if friend != null:
				if friend.catagory == catagories.MAXMORPHEDS or (upgraded and friend.catagory == catagories.SCHMERLOCK):
					target_friends.append(friend)
		for friend in target_friends:
			proc()
			options.shuffle()
			match options[0]:
				"hp":
					friend.hp += 4
					Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, "4")
					await get_tree().create_timer(0.2).timeout
				"attack":
					friend.attack += 1
					Manager.move_symbol(global_position, friend.global_position, most_attack_target_texture, "1")
					await get_tree().create_timer(0.2).timeout
			friend.setStatText()
		if target_friends.size() > 0:
			await proc()
