extends Card

var previousHealth = 50
var teamMoney
var coin_index

func end_turn():
	if not blocked_ability:
		previousHealth = hp
		var image = get_node("image")
		if card_name == "Michael Jackson":
			if not upgraded:
				for friend in Manager.friends:
					if friend != null and friend.catagory == catagories.SIBLINGS: #sibling
						friend.attack += 2
						Manager.move_symbol(global_position, friend.global_position, attack_icon, "2")
					elif friend != null and friend.catagory == catagories.SONGS_MUSICIANS_INSTRUMENTS: #music
						attack +=1
						Manager.move_symbol(friend.global_position, global_position, attack_icon, "1")
			#sibling and instrument ability
			elif upgraded:
				for friend in Manager.friends:
					if friend != null and friend.catagory == catagories.SIBLINGS:
						friend.attack += 3
						Manager.move_symbol(global_position, friend.global_position, attack_icon, "3")
					elif friend != null and friend.catagory == catagories.SONGS_MUSICIANS_INSTRUMENTS:
						attack +=2
						Manager.move_symbol(friend.global_position, global_position, attack_icon, "2")
			setStatText()
			#image scale for 5 is 0.8
			if hp >= 24:
				card_name = "Michael Jackson Thriller"
				attack += 1
				Manager.move_symbol(global_position, global_position, attack_icon, "1")
				x += 1
				Manager.move_symbol(global_position, global_position, x_icon, "1")
				ability = "END TURN: Get 5 coin and 1 attack for each music friend. If this card has 35 hp , become Allegations friend."
				upgradedAbility = "END TURN: Get 10 coin and 2 attack for each music friend. If this card has 35 hp , become Allegations friend."
				image.texture = load("res://assets/friends/michael_jackson_thriller.jpg")
				image.scale = Vector2(0.4,0.4)
				setStatText()
				setAbilityText()
				#await Manager.card_summoned(team_number, self)
		if card_name == "Michael Jackson Thriller":
			for friend in Manager.friends:
				if friend != null and friend.catagory == catagories.SONGS_MUSICIANS_INSTRUMENTS: #music
					if not upgraded:
						Manager.money += 5
						attack +=1
						Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "5")
						Manager.move_symbol(global_position, friend.global_position, attack_icon, "1")
						shopScene.updateText()
					elif upgraded:
						Manager.money += 10
						attack += 2
						Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, "10")
						Manager.move_symbol(global_position, friend.global_position, attack_icon, "2")
			#image scale for 5 is 0.8
			if hp >= 35:
				card_name = "Michael Jackson Allegations"
				attack = 1
				Manager.move_symbol(global_position, global_position, minus_icon,"")
				x = 1
				ability = "HURT: Spend 5 gold and kill the attacking friend. END TURN: If this card has 50 hp , become This Is It friend."
				upgradedAbility = "HURT: Spend 2 gold and kill the attacking friend. END TURN: If this card has 50 hp , become This Is It friend."
				image.texture = load("res://assets/friends/michael_jackson_allegations.jpg")
				image.scale = Vector2(0.18,0.18)
				setStatText()
				setAbilityText()
				#await Manager.card_summoned(team_number, self)	
		if card_name == "Michael Jackson Allegations" and hp >= 50:
				card_name = "Michael Jackson This Is It"
				ability = "HURT: Deal damage received back to attacker. DIES: Gain 5 coin"
				upgradedAbility = "HURT: Deal double damage received back to attacker. DIES: Gain 10 coin"
				image.texture = load("res://assets/friends/michael_jackson_this_is_it.jpg")
				image.scale = Vector2(0.92,0.92)
				setStatText()
				setAbilityText()
				#await Manager.card_summoned(team_number, self)				
		await proc()
func start_battle():
	var arena_scene = get_tree().get_first_node_in_group("arena")
	var image = get_node("image")
	if card_name == "Michael Jackson Thriller":
		image.texture = load("res://assets/friends/michael_jackson_thriller.jpg")
		image.scale = Vector2(0.4,0.4)
	elif card_name == "Michael Jackson Allegations":
		image.texture = load("res://assets/friends/michael_jackson_allegations.jpg")
		image.scale = Vector2(0.18,0.18)	
	elif card_name == "Michael Jackson This Is It":
		image.texture = load("res://assets/friends/michael_jackson_this_is_it.jpg")
		image.scale = Vector2(0.92,0.92)
	match team_number:
		1:
			teamMoney = arena_scene.p1stats
			coin_index = 0
		2:
			teamMoney = arena_scene.p2stats
			coin_index = 1
		3:
			teamMoney = arena_scene.p3stats
			coin_index = 3
		4:
			teamMoney = arena_scene.p4stats
			coin_index = 4
	await proc()	
	

func hurt(attacker):
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		if card_name == "Michael Jackson Allegations":
			if not upgraded:
				if teamMoney[arena_scene.MONEY] >= 5:
					teamMoney[arena_scene.MONEY] -= 5
					Manager.move_symbol( arena_scene.coin_icons[coin_index].global_position,global_position,  coin_icon, str(5))
					await attack_opponent(attacker, attacker.hp, arena_scene)

			elif upgraded:
				if teamMoney[arena_scene.MONEY] >= 2:
					teamMoney[arena_scene.MONEY] -= 2
					Manager.move_symbol( arena_scene.coin_icons[coin_index].global_position,global_position,  coin_icon, str(2))
					await attack_opponent(attacker, attacker.hp, arena_scene)
		elif card_name == "Michael Jackson This Is It":
			var damageToDo = 0
			if not upgraded:
				damageToDo = previousHealth - hp
			elif upgraded:
				damageToDo = 2 * (previousHealth - hp)
			previousHealth = hp
			await attack_opponent(attacker, damageToDo, arena_scene)
		arena_scene.update_text()
		await proc()
		
func die(killer):
	if not blocked_ability:
		var arena_scene = get_tree().get_first_node_in_group("arena")
		if card_name == "Michael Jackson This Is It":
			if not upgraded:
				teamMoney[arena_scene.MONEY] += 5
				Manager.move_symbol( global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(5))
			elif upgraded:
				teamMoney[arena_scene.MONEY] += 10
				Manager.move_symbol( global_position, arena_scene.coin_icons[coin_index].global_position, coin_icon, str(10))
		arena_scene.update_text()
		await proc()
			
