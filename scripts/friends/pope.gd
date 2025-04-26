extends Card


# Called when the node enters the scene tree for the first time.
func hurt(attacker):
	if not blocked_ability and card_name != "Conclave":
		var image = get_node("image")
		if hp <= 0:
			card_name = "Conclave"
			hp = 25
			attack = 5
			x = 2
			this_x = 2
			target = 0
			colour = 2
			if upgraded:
				upgradedAbility = "FRIEND AHEAD ATTACKS: Attacking friend gains 20 hp"
			else:
				ability = "FRIEND AHEAD ATTACKS: Attacking friend gains 10 hp" # check if that friend has more than 0 health
			image.texture = load("res://assets/friends/conclave.jpg")
			image.scale = Vector2(1,1)
			setStatText()
			setAbilityText()
			await Manager.card_summoned(team_number,self)
			
			
		await proc()
		
		
func friend_ahead_attacks(friend):
	if card_name == "Conclave" and friend.hp > 0 and not blocked_ability:
		if not upgraded:
			friend.hp += 10
			Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, str(10))
		elif upgraded:
			friend.hp += 20
			Manager.move_symbol(global_position, friend.global_position, most_hp_target_texture, str(20))
		await proc()
