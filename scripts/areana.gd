extends Node2D

var rng = RandomNumberGenerator.new()

enum targets {CLOCKWISE = 0, RANDOM = 1, MOST_HP = 2,
LEAST_HP = 3, MOST_ATTACK = 4, LEAST_ATTACK = 5, MOST_WINS = 6, LEAST_WINS = 7,
MATT = 8, JOSH = 9, JAMES = 10, HARRY = 11}

# CARD SPOTS
@onready var p1card_spots = [$player1cards/activeSpot, $player1cards/spot2, $player1cards/spot3, $player1cards/spot4, $player1cards/spot5, $player1cards/spot6]
@onready var p2card_spots = [$player2cards/activeSpot, $player2cards/spot2, $player2cards/spot3, $player2cards/spot4, $player2cards/spot5, $player2cards/spot6]
@onready var p3card_spots = [$player3cards/activeSpot, $player3cards/spot2, $player3cards/spot3, $player3cards/spot4, $player3cards/spot5, $player3cards/spot6]
@onready var p4card_spots = [$player4cards/activeSpot, $player4cards/spot2, $player4cards/spot3, $player4cards/spot4, $player4cards/spot5, $player4cards/spot6]

var ghost_card = preload("res://scenes/ghost.tscn")
@onready var player_ghosts = [null, null, null, null]

var coin_symbol = preload("res://assets/card_icons/cost_icon.png")

# TEAMS
var p1team = [null, null, null, null, null, null]
var p2team = [null, null, null, null, null, null]
var p3team = [null, null, null, null, null, null]
var p4team = [null, null, null, null, null, null]

# CARD COPIES FOR FIGHTING
var p1cards = [null, null, null, null, null, null]
var p2cards = [null, null, null, null, null, null]
var p3cards = [null, null, null, null, null, null]
var p4cards = [null, null, null, null, null, null]

# PLAYER STATS
const WINS = 0
const MONEY = 1
const LEADER = 2
var p1stats = [0, 0, "-"]
var p2stats = [0, 0, "-"]
var p3stats = [0, 0, "-"]
var p4stats = [0, 0, "-"]

var alive = [true, true, true, true]

var card_proc_order = []
var card_proc_order_backup = []
var card_proc_order_kill = []
var card_proc_order_die = []
var card_proc_order_hurt = []

var p1cardsDied = []
var p2cardsDied = []
var p3cardsDied = []
var p4cardsDied = []

var random_floats = [0, 0, 0, 0, 0, 0, 0]

@onready var p1wins_text = $UI/winsP1
@onready var p2wins_text = $UI/winsP2
@onready var p3wins_text = $UI/winsP3
@onready var p4wins_text = $UI/winsP4
@onready var p1money_text = $UI/moneyP1
@onready var p2money_text = $UI/moneyP2
@onready var p3money_text = $UI/moneyP3
@onready var p4money_text = $UI/moneyP4

@onready var coin_icons = [$moneyP1, $moneyP2, $moneyP3, $moneyP4]

var winner = []
var this_attacker
var found = false
var previous_round_alive_cards = [true, true, true, true]

@onready var shop = $"../GameShop"
@onready var winner_screen = $"../EndScene"

@export var p1team_data = []
var p2team_data = []
var p3team_data = []
var p4team_data = []
var shared_p1stats
var shared_p2stats
var shared_p3stats
var shared_p4stats

var can_start_round = false
var can_start_to_fight = [false, false, false, false]

var test_mode = false

func _ready():
	p1stats = Manager.statsP1.duplicate()
	p2stats = Manager.statsP2.duplicate()
	p3stats = Manager.statsP3.duplicate()
	p4stats = Manager.statsP4.duplicate()
	update_text()
	can_start_round = true

func _process(_delta):
	if can_start_round and Manager.ready_players == 4:
		start_round.rpc()
		can_start_round = false
		await get_tree().create_timer(0.07).timeout
	if can_start_to_fight.count(true) == 4:
		can_start_to_fight = [false, false, false, false]
		begin_fighting()
		await get_tree().create_timer(0.07).timeout
	if Input.is_action_just_pressed("kickstart_fighting"):
		Manager.ready_players = 4
		can_start_to_fight = [true, true, true, true]
		test_mode = true
		shared_p2stats = [0, 0, "test"]
		shared_p3stats = [0, 0, "test"]
		shared_p4stats = [0, 0, "test"]

@rpc("any_peer", "call_local")
func start_round():
	if multiplayer.get_remote_sender_id() == multiplayer.get_unique_id():
		match Manager.playerNum:
			1:
				for card in Manager.teamP1:
					p1team_data.append(Manager.convert_card_to_data(card))
				shared_p1stats = p1stats
				random_floats = Manager.rand_floats
				set_p1_team_and_stats.rpc(p1team_data, shared_p1stats, random_floats)
			2:
				for card in Manager.teamP2:
					p2team_data.append(Manager.convert_card_to_data(card))
				shared_p2stats = p2stats
				set_p2_team_and_stats.rpc(p2team_data, shared_p2stats)
			3:
				for card in Manager.teamP3:
					p3team_data.append(Manager.convert_card_to_data(card))
				shared_p3stats = p3stats
				set_p3_team_and_stats.rpc(p3team_data, shared_p3stats)
			4:
				for card in Manager.teamP4:
					p4team_data.append(Manager.convert_card_to_data(card))
				shared_p4stats = p4stats
				set_p4_team_and_stats.rpc(p4team_data, shared_p4stats)

@rpc("any_peer", "call_local")
func set_p1_team_and_stats(this_team, this_stats, this_floats):
	random_floats = this_floats
	p1team_data = this_team
	shared_p1stats = this_stats
	can_start_to_fight[0] = true

@rpc("any_peer", "call_local")
func set_p2_team_and_stats(this_team, this_stats):
	p2team_data = this_team
	shared_p2stats = this_stats
	can_start_to_fight[1] = true

@rpc("any_peer", "call_local")
func set_p3_team_and_stats(this_team, this_stats):
	p3team_data = this_team
	shared_p3stats = this_stats
	can_start_to_fight[2] = true

@rpc("any_peer", "call_local")
func set_p4_team_and_stats(this_team, this_stats):
	p4team_data = this_team
	shared_p4stats = this_stats
	can_start_to_fight[3] = true

func add_team_to_battlefield():
	place_cards_into_position()

func place_cards_into_position():
	p1cards = p1team.duplicate()
	for i in range(6):
		if p1cards[i] != null:
			add_child(p1cards[i])
			p1cards[i].global_position = p1card_spots[i].global_position
			p1cards[i].inBattle = true
			p1cards[i].starting_fighting_slot = p1team[i].starting_fighting_slot
			p1cards[i].team_number = 1
			p1cards[i].hp = min(250, p1cards[i].hp)
			p1cards[i].attack = min(50, p1cards[i].attack)
			p1cards[i].x = min(15, p1cards[i].x)
	while null in p1cards:
		p1cards.erase(null)
	p2cards = p2team.duplicate()
	for i in range(6):
		if p2cards[i] != null:
			add_child(p2cards[i])
			p2cards[i].global_position = p2card_spots[i].global_position
			p2cards[i].inBattle = true
			p2cards[i].starting_fighting_slot = p2team[i].starting_fighting_slot
			p2cards[i].team_number = 2
			p2cards[i].hp = min(250, p2cards[i].hp)
			p2cards[i].attack = min(50, p2cards[i].attack)
			p2cards[i].x = min(15, p2cards[i].x)
	while null in p2cards:
		p2cards.erase(null)
	p3cards = p3team.duplicate()
	for i in range(6):
		if p3cards[i] != null:
			add_child(p3cards[i])
			p3cards[i].global_position = p3card_spots[i].global_position
			p3cards[i].inBattle = true
			p3cards[i].starting_fighting_slot = p3team[i].starting_fighting_slot
			p3cards[i].team_number = 3
			p3cards[i].hp = min(250, p3cards[i].hp)
			p3cards[i].attack = min(50, p3cards[i].attack)
			p3cards[i].x = min(15, p3cards[i].x)
	while null in p3cards:
		p3cards.erase(null)
	p4cards = p4team.duplicate()
	for i in range(6):
		if p4cards[i] != null:
			add_child(p4cards[i])
			p4cards[i].global_position = p4card_spots[i].global_position
			p4cards[i].inBattle = true
			p4cards[i].starting_fighting_slot = p4team[i].starting_fighting_slot
			p4cards[i].team_number = 4
			p4cards[i].hp = min(250, p4cards[i].hp)
			p4cards[i].attack = min(50, p4cards[i].attack)
			p4cards[i].x = min(15, p4cards[i].x)
	while null in p4cards:
		p4cards.erase(null)

func prepare_cards():
	"""
	while p1team.size() < 6:
		p1team.append(null)
	while p2team.size() < 6:
		p2team.append(null)
	while p3team.size() < 6:
		p3team.append(null)
	while p4team.size() < 6:
		p4team.append(null)
	"""
	for i in range(6):
		if test_mode:
			Manager.teamP2 = [null, null, null, null, null, null]
			Manager.teamP3 = [null, null, null, null, null, null]
			Manager.teamP4 = [null, null, null, null, null, null]
			p2team_data = [null, null, null, null, null, null]
			p3team_data = [null, null, null, null, null, null]
			p4team_data = [null, null, null, null, null, null]
			for j in range(3):
				Manager.teamP2[j] = load("res://scenes/january_5_th.tscn").instantiate()
				Manager.teamP3[j] = load("res://scenes/january_5_th.tscn").instantiate()
				Manager.teamP4[j] = load("res://scenes/security_guard.tscn").instantiate()
				Manager.teamP2[j].gather_fighting_info()
				Manager.teamP3[j].gather_fighting_info()
				Manager.teamP4[j].gather_fighting_info()
				p2team_data[j] = Manager.convert_card_to_data(Manager.teamP2[j])
				p3team_data[j] = Manager.convert_card_to_data(Manager.teamP3[j])
				p4team_data[j] = Manager.convert_card_to_data(Manager.teamP4[j])
		if Manager.teamP1.size() > i and Manager.teamP1[i] != null:
			p1team[i] = Manager.teamP1[i].duplicate()
			p1team[i].inBattle = true
			p1team[i].starting_fighting_slot = i
		if Manager.teamP2.size() > i and Manager.teamP2[i] != null:
			p2team[i] = Manager.teamP2[i].duplicate()
			p2team[i].inBattle = true
			p2team[i].starting_fighting_slot = i
		if Manager.teamP3.size() > i and Manager.teamP3[i] != null:
			p3team[i] = Manager.teamP3[i].duplicate()
			p3team[i].inBattle = true
			p3team[i].starting_fighting_slot = i
		if Manager.teamP4.size() > i and Manager.teamP4[i] != null:
			p4team[i] = Manager.teamP4[i].duplicate()
			p4team[i].inBattle = true
			p4team[i].starting_fighting_slot = i

func begin_fighting():
	p1stats = shared_p1stats
	p2stats = shared_p2stats
	p3stats = shared_p3stats
	p4stats = shared_p4stats
	await Manager.set_player_teams(1, p1team_data)
	await Manager.set_player_teams(2, p2team_data)
	await Manager.set_player_teams(3, p3team_data)
	await Manager.set_player_teams(4, p4team_data)
	prepare_cards()
	Manager.teamP1 = p1team.duplicate()
	Manager.teamP2 = p2team.duplicate()
	Manager.teamP3 = p3team.duplicate()
	Manager.teamP4 = p4team.duplicate()
	Manager.saved_team1 = p1team_data
	Manager.saved_team2 = p2team_data
	Manager.saved_team3 = p3team_data
	Manager.saved_team4 = p4team_data
	p1team_data = []
	p2team_data = []
	p3team_data = []
	p4team_data = []
	for i in range(4):
		player_ghosts[i] = ghost_card.instantiate()
		add_child(player_ghosts[i])
	update_text()
	start_battle()

func start_battle():
	place_cards_into_position()
	makeActive(p1cards[0], 1)
	makeActive(p2cards[0], 2)
	makeActive(p3cards[0], 3)
	makeActive(p4cards[0], 4)
	for card in p1cards:
		while card.team_number in card.targets_order:
			card.targets_order.erase(card.team_number)
	for card in p2cards:
		while card.team_number in card.targets_order:
			card.targets_order.erase(card.team_number)
	for card in p3cards:
		while card.team_number in card.targets_order:
			card.targets_order.erase(card.team_number)
	for card in p4cards:
		while card.team_number in card.targets_order:
			card.targets_order.erase(card.team_number)
	Manager.ready_players = 0
	await activate_start_battles()
	await activate_dies()
	await activate_kills()
	await process_all_dead_cards()
	await replace_empty_teams_with_a_ghost()
	await update_all_cards_text()
	await activate_friend_dies()
	card_proc_order = [p1cards[0], p2cards[0], p3cards[0], p4cards[0]]
	await activate_before_attacks()
	await activate_dies()
	await activate_kills()
	await process_all_dead_cards()
	await replace_empty_teams_with_a_ghost()
	await update_all_cards_text()
	await activate_friend_dies()
	$startFighting.start()

func remove_empty_team_positions():
	while null in p1team:
		p1team.erase(null)
	while null in p2team:
		p2team.erase(null)
	while null in p3team:
		p3team.erase(null)
	while null in p4team:
		p4team.erase(null)

func activate_start_battles():
	card_proc_order.clear()
	card_proc_order.append_array(p1cards)
	card_proc_order.append_array(p2cards)
	card_proc_order.append_array(p3cards)
	card_proc_order.append_array(p4cards)
	card_proc_order.sort_custom(sort_hp)
	await get_tree().create_timer(0.8).timeout
	for card in card_proc_order:
		await card.start_battle()
		await update_all_cards_text()

func activate_dies():
	card_proc_order_die.sort_custom(sort_attack)
	while card_proc_order_die.size() > 0:
		if card_proc_order_die[0][0] != null:
			await card_proc_order_die[0][0].die(card_proc_order_die[0][1])
		card_proc_order_die.pop_front()

func activate_kills():
	card_proc_order_kill.sort_custom(sort_hp_kill)
	update_text()
	while card_proc_order_kill.size() > 0:
		await card_proc_order_kill[0][0].kill(card_proc_order_kill[0][1], card_proc_order_kill[0][2])
		card_proc_order_kill.pop_front()
	card_proc_order_kill.clear()

func replace_empty_teams_with_a_ghost():
	if p1cards.size() == 0:
		p1cards = [player_ghosts[0]]
	if p2cards.size() == 0:
		p2cards = [player_ghosts[1]]
	if p3cards.size() == 0:
		p3cards = [player_ghosts[2]]
	if p4cards.size() == 0:
		p4cards = [player_ghosts[3]]

func activate_friend_dies():
	card_proc_order_backup.sort_custom(sort_hp_kill)
	for card in card_proc_order_backup:
		if card[0] != null:
			await card[0].friend_dies(card[1])
	card_proc_order_backup.clear()

func activate_before_attacks():
	card_proc_order.sort_custom(sort_hp)
	for card in card_proc_order:
		await card.before_attack()

func sort_hp(a, b):
	if a.hp > b.hp:
		return true
	return false

func sort_hp_kill(a, b):
	if a[0].hp > b[0].hp:
		return true
	return false

func sort_attack(a, b):
	if a[0] != null and b[0] != null:
		if a[0].attack > b[0].attack:
			return true
	return false

func makeActive(card, player):
	card.grow_size = 3
	card.shrink_size = 2
	card.active = true
	card.scale.x = 2
	card.scale.y = 2
	match player:
		1:
			card.global_position = p1card_spots[0].global_position
			card.start_pos = card.global_position
		2:
			card.global_position = p2card_spots[0].global_position
			card.start_pos = card.global_position
		3:
			card.global_position = p3card_spots[0].global_position
			card.start_pos = card.global_position
		4:
			card.global_position = p4card_spots[0].global_position
			card.start_pos = card.global_position

func _on_start_fighting_timeout():
	attack_round()

func attack_round():
	if ((p1cards[0].this_x > 0 and (p2cards[0].hp > 0 or p3cards[0].hp > 0 or p4cards[0].hp > 0)) or (p2cards[0].this_x > 0 and (p1cards[0].hp > 0 or p3cards[0].hp > 0 or p4cards[0].hp > 0)) or (p3cards[0].this_x > 0 and (p2cards[0].hp > 0 or p1cards[0].hp > 0 or p4cards[0].hp > 0)) or (p4cards[0].this_x > 0 and (p2cards[0].hp > 0 or p3cards[0].hp > 0 or p1cards[0].hp > 0))) and (p1cards[0].hp > 0 or p2cards[0].hp > 0 or p3cards[0].hp > 0 or p4cards[0].hp > 0):
		await cards_attack()
		await update_all_cards_text()
		await activate_hurts()
		$betweenHits.start()
	else:
		card_proc_order = [p1cards[0], p2cards[0], p3cards[0], p4cards[0]]
		await activate_after_attacks()
		await activate_friend_ahead_attacks()
		reset_card_x_values()
		await add_cards_to_friend_dies_activation_array()
		await activate_dies()
		await activate_kills()
		await process_all_dead_cards()
		await replace_empty_teams_with_a_ghost()
		await update_all_cards_text()
		await activate_friend_dies()
		$betweenAttackRounds.start()

func activate_hurts():
	card_proc_order_hurt.sort_custom(sort_hp_kill)
	for i in range(card_proc_order_hurt.size()):
		await card_proc_order_hurt[i][0].hurt(card_proc_order_hurt[i][1])
	card_proc_order_hurt.clear()

func activate_after_attacks():
	card_proc_order.sort_custom(sort_hp)
	for card in card_proc_order:
		await card.after_attack()
	card_proc_order.clear()

func activate_friend_ahead_attacks():
	if p1cards.size() > 1:
		card_proc_order.append(p1cards[1])
	if p2cards.size() > 1:
		card_proc_order.append(p2cards[1])
	if p3cards.size() > 1:
		card_proc_order.append(p3cards[1])
	if p4cards.size() > 1:
		card_proc_order.append(p4cards[1])
	card_proc_order.sort_custom(sort_hp)
	for card in card_proc_order:
		if card in p1cards:
			await card.friend_ahead_attacks(p1cards[0])
		if card in p2cards:
			await card.friend_ahead_attacks(p2cards[0])
		if card in p3cards:
			await card.friend_ahead_attacks(p3cards[0])
		if card in p4cards:
			await card.friend_ahead_attacks(p4cards[0])

func reset_card_x_values():
	p1cards[0].this_x = p1cards[0].x
	p2cards[0].this_x = p2cards[0].x
	p3cards[0].this_x = p3cards[0].x
	p4cards[0].this_x = p4cards[0].x

func add_cards_to_friend_dies_activation_array():
	if p1cards[0].hp <= 0:
		if p1cards.size() > 1:
			for i in range(1, p1cards.size()):
				card_proc_order_backup.append([p1cards[i], p1cards[0].catagory])
	if p2cards[0].hp <= 0:
		if p2cards.size() > 1:
			for i in range(1, p2cards.size()):
				card_proc_order_backup.append([p2cards[i], p2cards[0].catagory])
	if p3cards[0].hp <= 0:
		if p3cards.size() > 1:
			for i in range(1, p3cards.size()):
				card_proc_order_backup.append([p3cards[i], p3cards[0].catagory])
	if p4cards[0].hp <= 0:
		if p4cards.size() > 1:
			for i in range(1, p4cards.size()):
				card_proc_order_backup.append([p4cards[i], p4cards[0].catagory])

func process_all_dead_cards():
	await card_dies_step1(p1cards, p1cardsDied)
	await card_dies_step1(p2cards, p2cardsDied)
	await card_dies_step1(p3cards, p3cardsDied)
	await card_dies_step1(p4cards, p4cardsDied)
	await card_dies_step2(p1cards, p1cardsDied)
	await card_dies_step2(p2cards, p2cardsDied)
	await card_dies_step2(p3cards, p3cardsDied)
	await card_dies_step2(p4cards, p4cardsDied)
	await card_dies_step3(p1cards, p1cardsDied, 0)
	await card_dies_step3(p2cards, p2cardsDied, 1)
	await card_dies_step3(p3cards, p3cardsDied, 2)
	await card_dies_step3(p4cards, p4cardsDied, 3)

func cards_attack():
	var victims = [0, 0, 0, 0]
	await find_attack_targets_for_all_cards(victims)
	await all_cards_attack(victims)
	card_proc_order_backup.clear()
	await add_hurt_cards_to_hurt_proc_order_array(victims)
	await decrement_all_cards_x_value()

func find_attack_targets_for_all_cards(victims):
	if p1cards[0].this_x > 0:
		victims[0] = find_target(p1cards[0], 1, p2cards[0], 2, p2stats, p3cards[0], 3, p3stats, p4cards[0], 4, p4stats)
	if p2cards[0].this_x > 0:
		victims[1] = find_target(p2cards[0], 2, p1cards[0], 1, p1stats, p3cards[0], 3, p3stats, p4cards[0], 4, p4stats)
	if p3cards[0].this_x > 0:
		victims[2] = find_target(p3cards[0], 3, p2cards[0], 2, p2stats, p1cards[0], 1, p1stats, p4cards[0], 4, p4stats)
	if p4cards[0].this_x > 0:
		victims[3] = find_target(p4cards[0], 4, p2cards[0], 2, p2stats, p3cards[0], 3, p3stats, p1cards[0], 1, p1stats)

func all_cards_attack(victims):
	if p1cards[0].this_x > 0:
		attack(1, victims[0])
	if p2cards[0].this_x > 0:
		attack(2, victims[1])
	if p3cards[0].this_x > 0:
		attack(3, victims[2])
	if p4cards[0].this_x > 0:
		attack(4, victims[3])

func add_hurt_cards_to_hurt_proc_order_array(victims):
	for i in range(victims.size()):
		match i:
			0:
				this_attacker = p1cards[0]
			1:
				this_attacker = p2cards[0]
			2:
				this_attacker = p3cards[0]
			3:
				this_attacker = p4cards[0]
		match victims[i]:
			1:
				card_proc_order_hurt.append([p1cards[0], this_attacker])
			2:
				card_proc_order_hurt.append([p2cards[0], this_attacker])
			3:
				card_proc_order_hurt.append([p3cards[0], this_attacker])
			4:
				card_proc_order_hurt.append([p4cards[0], this_attacker])

func decrement_all_cards_x_value():
	p1cards[0].this_x -= 1
	p2cards[0].this_x -= 1
	p3cards[0].this_x -= 1
	p4cards[0].this_x -= 1

func activate_kill_and_die_stuff(attacker, victim, num):
	card_proc_order_kill.append([attacker, num, victim.starting_fighting_slot])
	found = false
	for i in range(card_proc_order_die.size()):
		if card_proc_order_die[i][0] == victim:
			card_proc_order_die[i][1].append(attacker)
			found = true
	if not found:
		card_proc_order_die.append([victim, [attacker]])

func attack(attacker, victim):
	if victim == 0:
		pass
	else:
		await card_swings_at_victim(attacker, victim)

func swing(victim_card, attacking_card, dead_team_number, killing_team_index, swing_direction, stat_array_to_update):
	victim_card.hp -= attacking_card.attack
	if victim_card.hp <= 0:
		stat_array_to_update[MONEY] += 1
		activate_kill_and_die_stuff(attacking_card, victim_card, dead_team_number)
		await Manager.move_symbol(victim_card.global_position, coin_icons[killing_team_index].global_position, coin_symbol, "")
	attacking_card.attack_swing(swing_direction)

func card_swings_at_victim(attacker, victim):
	match attacker:
		1:
			if victim == 2:
				await swing(p2cards[0], p1cards[0], 2, 0, "E", p1stats)
			elif victim == 3:
				await swing(p3cards[0], p1cards[0], 3, 0, "S", p1stats)
			elif victim == 4:
				await swing(p4cards[0], p1cards[0], 4, 0, "SE", p1stats)
		2:
			if victim == 1:
				await swing(p1cards[0], p2cards[0], 1, 1, "W", p2stats)
			elif victim == 3:
				await swing(p3cards[0], p2cards[0], 3, 1, "SW", p2stats)
			elif victim == 4:
				await swing(p4cards[0], p2cards[0], 4, 1, "S", p2stats)
		3:
			if victim == 2:
				await swing(p2cards[0], p3cards[0], 2, 2, "NE", p3stats)
			elif victim == 1:
				await swing(p1cards[0], p3cards[0], 1, 2, "N", p3stats)
			elif victim == 4:
				await swing(p4cards[0], p3cards[0], 4, 2, "E", p3stats)
		4:
			if victim == 2:
				await swing(p2cards[0], p4cards[0], 2, 3, "N", p4stats)
			elif victim == 3:
				await swing(p3cards[0], p4cards[0], 3, 3, "W", p4stats)
			elif victim == 1:
				await swing(p1cards[0], p4cards[0], 1, 3, "NW", p4stats)

func find_target(this_card, _this_no, other_card1, other_no1, other_player1, other_card2, other_no2, other_player2, other_card3, other_no3, other_player3):
	var victim = 0
	var victim_hp = 0
	var hp_order = three_card_sort(other_no1, other_no2, other_no3, other_card1.hp, other_card2.hp, other_card3.hp)
	var attack_order = three_card_sort(other_no1, other_no2, other_no3, other_card1.attack, other_card2.attack, other_card3.attack)
	var wins_order = three_card_sort(other_no1, other_no2, other_no3, other_player1[WINS], other_player2[WINS], other_player3[WINS])
	while victim_hp <= 0 and (other_card1.hp > 0 or other_card2.hp > 0 or other_card3.hp > 0):
		match this_card.target:
			targets.CLOCKWISE, targets.RANDOM:
				victim = this_card.targets_order[this_card.next_target]
				this_card.next_target += 1
			targets.LEAST_HP:
				victim = hp_order.pop_back()
			targets.MOST_HP:
				victim = hp_order.pop_front()
			targets.LEAST_ATTACK:
				victim = attack_order.pop_back()
			targets.MOST_ATTACK:
				victim = attack_order.pop_front()
			targets.LEAST_WINS:
				victim = wins_order.pop_back()
			targets.MOST_WINS:
				victim = wins_order.pop_front()
			targets.MATT:
				if other_player1[LEADER] == "Matt Phillips" and other_card1.hp > 0:
					victim = other_no1
				elif other_player2[LEADER] == "Matt Phillips" and other_card2.hp > 0:
					victim = other_no2
				elif other_player3[LEADER] == "Matt Phillips" and other_card3.hp > 0:
					victim = other_no3
				else:
					victim = this_card.targets_order[this_card.next_target]
					this_card.next_target += 1
			targets.JOSH:
				if other_player1[LEADER] == "Josh" and other_card1.hp > 0:
					victim = other_no1
				elif other_player2[LEADER] == "Josh" and other_card2.hp > 0:
					victim = other_no2
				elif other_player3[LEADER] == "Josh" and other_card3.hp > 0:
					victim = other_no3
				else:
					victim = this_card.targets_order[this_card.next_target]
					this_card.next_target += 1
			targets.JAMES:
				if other_player1[LEADER] == "James" and other_card1.hp > 0:
					victim = other_no1
				elif other_player2[LEADER] == "James" and other_card2.hp > 0:
					victim = other_no2
				elif other_player3[LEADER] == "James" and other_card3.hp > 0:
					victim = other_no3
				else:
					victim = this_card.targets_order[this_card.next_target]
					this_card.next_target += 1
			targets.HARRY:
				if other_player1[LEADER] == "Harry" and other_card1.hp > 0:
					victim = other_no1
				elif other_player2[LEADER] == "Harry" and other_card2.hp > 0:
					victim = other_no2
				elif other_player3[LEADER] == "Harry" and other_card3.hp > 0:
					victim = other_no3
				else:
					victim = this_card.targets_order[this_card.next_target]
					this_card.next_target += 1
		victim_hp = find_victim_hp(victim)
	return victim

func three_card_sort(card1, card2, card3, stat1, stat2, stat3):
	var sorted = [card1]
	if stat1 > stat2:
		sorted.append(card2)
		if stat2 > stat3:
			sorted.append(card3)
		elif stat1 < stat3:
			sorted.insert(0, card3)
		elif stat2 == stat3:
			if 0.5 > random_floats[0]:
				sorted.append(card3)
			else:
				sorted.insert(1, card3)
		elif stat1 == stat3:
			if 0.5 > random_floats[1]:
				sorted.insert(0, card3)
			else:
				sorted.insert(1, card3)
		else:
			sorted.insert(1, card3)
	elif stat1 < stat2:
		sorted.insert(0, card2)
		if stat1 > stat3:
			sorted.append(card3)
		elif stat2 < stat3:
			sorted.insert(0, card3)
		elif stat1 == stat3:
			if 0.5 > random_floats[2]:
				sorted.append(card3)
			else:
				sorted.insert(1, card3)
		elif stat2 == stat3:
			if 0.5 > random_floats[3]:
				sorted.insert(0, card3)
			else:
				sorted.insert(1, card3)
		else:
			sorted.insert(1, card3)
	else:
		if 0.5 > random_floats[4]:
			sorted.append(card2)
		else:
			sorted.insert(0, card2)
		if stat1 > stat3:
			sorted.append(card3)
		elif stat1 < stat3:
			sorted.insert(0, card3)
		else:
			if 0.5 > random_floats[5]:
				sorted.append(card3)
			elif 0.5 > random_floats[6]:
				sorted.insert(1, card3)
			else:
				sorted.insert(0, card3)
	return sorted

func find_victim_hp(victimNum):
	var this_victim_hp
	match victimNum:
		1:
			this_victim_hp = p1cards[0].hp
		2:
			this_victim_hp = p2cards[0].hp
		3:
			this_victim_hp = p3cards[0].hp
		4:
			this_victim_hp = p4cards[0].hp
	return this_victim_hp

func card_dies_step1(card_set, dead_set):
	for i in range(card_set.size()):
		if card_set[i].hp <= 0:
			dead_set.append(card_set[i])

func card_dies_step2(card_set, dead_set):
	for card in dead_set:
		card_set.pop_at(card_set.find(card))
		if card.card_name != "ghost":
			card.queue_free()

func card_dies_step3(card_set, dead_set, player_no):
	dead_set.clear()
	if card_set.size() > 0 and not card_set[0].active:
		makeActive(card_set[0], player_no + 1)
	elif card_set.size() <= 0:
		alive[player_no] = false

func _on_between_hits_timeout():
	attack_round()

func _on_between_attack_rounds_timeout():
	winner.clear()
	if alive.count(true) == 1:
		for i in range(4):
			if alive[i]:
				winner.append(i + 1)
		end_fight()
	elif alive.count(true) <= 0:
		for i in range(previous_round_alive_cards.size()):
			if previous_round_alive_cards[i]:
				winner.append(i + 1)
		end_fight()
	else:
		previous_round_alive_cards = alive.duplicate()
		card_proc_order = [p1cards[0], p2cards[0], p3cards[0], p4cards[0]]
		await activate_before_attacks()
		await activate_dies()
		await activate_kills()
		await process_all_dead_cards()
		await replace_empty_teams_with_a_ghost()
		await update_all_cards_text()
		await activate_friend_dies()
		attack_round()

func update_text():
	p1wins_text.text = str(p1stats[WINS])
	p2wins_text.text = str(p2stats[WINS])
	p3wins_text.text = str(p3stats[WINS])
	p4wins_text.text = str(p4stats[WINS])
	p1money_text.text = str(p1stats[MONEY])
	p2money_text.text = str(p2stats[MONEY])
	p3money_text.text = str(p3stats[MONEY])
	p4money_text.text = str(p4stats[MONEY])

var overall_winner = []
func end_fight():
	Manager.previous_round_winner = winner.duplicate()
	if 1 in winner:
		p1stats[WINS] += 1
		if p1stats[WINS] == Manager.victory_wins:
			overall_winner.append(1)
	if 2 in winner:
		p2stats[WINS] += 1
		if p2stats[WINS] == Manager.victory_wins:
			overall_winner.append(2)
	if 3 in winner:
		p3stats[WINS] += 1
		if p3stats[WINS] == Manager.victory_wins:
			overall_winner.append(3)
	if 4 in winner:
		p4stats[WINS] += 1
		if p4stats[WINS] == Manager.victory_wins:
			overall_winner.append(4)
	match Manager.playerNum:
		1:
			Manager.wins = p1stats[WINS]
			Manager.money = p1stats[MONEY]
		2:
			Manager.wins = p2stats[WINS]
			Manager.money = p2stats[MONEY]
		3:
			Manager.wins = p3stats[WINS]
			Manager.money = p3stats[MONEY]
		4:
			Manager.wins = p4stats[WINS]
			Manager.money = p4stats[MONEY]
	Manager.statsP1 = p1stats.duplicate()
	Manager.statsP2 = p2stats.duplicate()
	Manager.statsP3 = p3stats.duplicate()
	Manager.statsP4 = p4stats.duplicate()
	if overall_winner.size() > 0:
		winner_screen.visible = true
		winner_screen.leader_card_data1 = Manager.saved_team1[-1]
		winner_screen.leader_card_data2 = Manager.saved_team2[-1]
		winner_screen.leader_card_data3 = Manager.saved_team3[-1]
		winner_screen.leader_card_data4 = Manager.saved_team4[-1]
		winner_screen.win_counts = [p1stats[WINS], p2stats[WINS], p3stats[WINS], p4stats[WINS]]
		winner_screen.construct_scene()
		await get_tree().create_timer(0).timeout
		queue_free()
	else:
		shop.visible = true
		await get_tree().create_timer(0).timeout
		shop.start_turn()
		queue_free()

func update_all_cards_text():
	for card in p1cards:
		if card != null:
			card.hp = max(0, card.hp)
			card.setStatText()
	for card in p2cards:
		if card != null:
			card.hp = max(0, card.hp)
			card.setStatText()
	for card in p3cards:
		if card != null:
			card.hp = max(0, card.hp)
			card.setStatText()
	for card in p4cards:
		if card != null:
			card.hp = max(0, card.hp)
			card.setStatText()
