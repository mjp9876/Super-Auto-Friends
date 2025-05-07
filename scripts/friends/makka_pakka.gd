extends Card


func start_turn():
	options.shuffle()
	ability = "START TURN: Change when the below ability triggers\n" + options[0] + ": +2 attack"
	upgradedAbility = "START TURN: Change when the below ability triggers\n" + options[0] + ": +5 hp , +2 attack"
	setAbilityText()
	await proc()

func buy():
	options = ["END TURN", "BUY CARD", "FRIEND SUMMONED", "SELL CARD", "USE ITEM", "FRIEND USES ITEM", " reroll_icon ", "START BATTLE", "FRIEND DIES", "FRIEND AHEAD ATTACKS", "BEFORE ATTACK", "AFTER ATTACK", "KILL", "HURT", "ENEMY SUMMONED"]

func ability_function():
	proc()
	if upgraded and hp > 0:
		hp += 5
		Manager.move_symbol(global_position, global_position, most_hp_target_texture, "5")
		await get_tree().create_timer(0.2).timeout
	attack += 2
	Manager.move_symbol(global_position, global_position, most_attack_target_texture, "2")
	setStatText()
	await proc()

func buy_card(_card):
	if not blocked_ability and options[0] == "BUY CARD":
		await ability_function()

func friend_summoned(_friend):
	if not blocked_ability and options[0] == "FRIEND SUMMONED":
		await ability_function()

func sell_card(_colour, _cost):
	if not blocked_ability and options[0] == "SELL CARD":
		await ability_function()

func use_item():
	if not blocked_ability and options[0] == "USE ITEM":
		await ability_function()

func friend_uses_item(_friend):
	if not blocked_ability and options[0] == "FRIEND USES ITEM":
		await ability_function()

func reroll():
	if not blocked_ability and options[0] == " reroll_icon ":
		await ability_function()

func end_turn():
	if not blocked_ability and options[0] == "END TURN":
		await ability_function()

func start_battle():
	if not blocked_ability and options[0] == "START BATTLE":
		await ability_function()

func friend_dies(_dead_friend_catagory):
	if not blocked_ability and options[0] == "FRIEND DIES":
		await ability_function()

func friend_ahead_attacks(_friend):
	if not blocked_ability and options[0] == "FRIEND AHEAD ATTACKS":
		await ability_function()

func before_attack():
	if not blocked_ability and options[0] == "BEFORE ATTACK":
		await ability_function()

func after_attack():
	if not blocked_ability and options[0] == "AFTER ATTACK":
		await ability_function()

func kill(_dead_team, _dead_team_index):
	if not blocked_ability and options[0] == "KILL":
		await ability_function()

func hurt(_attacker):
	if not blocked_ability and options[0] == "HURT":
		await ability_function()

func enemy_summoned(_enemy):
	if not blocked_ability and options[0] == "ENEMY SUMMONED":
		await ability_function()
