extends Card


# Called when the node enters the scene tree for the first time.
func hurt(attacker):
	if not blocked_ability and not upgraded and card_name != "Conclave":
		var image = get_node("image")
		if hp <= 0:
			card_name = "Conclave"
			cost = 7
			hp = 25
			attack = 5
			x = 2
			this_x = 2
			target = 0
			colour = 2
			ability = "FRIEND AHEAD HURT: Hurt friend gains 20 hp"
			image.texture = load("res://assets/friends/conclave.jpg")
			image.scale = Vector2(1,1)
			setStatText()
			setAbilityText()
			
			
		await proc()
		
