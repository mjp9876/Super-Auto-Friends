extends Node2D

class_name Card

var rng = RandomNumberGenerator.new()

# CONSTANTS
# Targets
enum targets {CLOCKWISE = 0, RANDOM = 1, MOST_HP = 2,
LEAST_HP = 3, MOST_ATTACK = 4, LEAST_ATTACK = 5, MOST_WINS = 6, LEAST_WINS = 7,
MATT = 8, JOSH = 9, JAMES = 10, HARRY = 11}

var clockwise_target_texture: Resource = load("res://assets/card_icons/clockwise_target_icon.png")
var random_target_texture: Resource = load("res://assets/card_icons/random_target_icon.png")
var most_hp_target_texture: Resource = load("res://assets/card_icons/most_HP_target_icon.png")
var least_hp_target_texture: Resource = load("res://assets/card_icons/least_HP_target_icon.png")
var most_attack_target_texture: Resource = load("res://assets/card_icons/most_attack_target_icon.png")
var least_attack_target_texture: Resource = load("res://assets/card_icons/least_attack_target_icon.png")
var most_wins_target_texture: Resource = load("res://assets/card_icons/most_wins_target_icon.png")
var least_wins_target_texture: Resource = load("res://assets/card_icons/least_wins_target_icon.png")
var matt_target_texture: Resource = load("res://assets/card_icons/matt_target_icon.png")
var josh_target_texture: Resource = load("res://assets/card_icons/josh_target_icon.png")
var james_target_texture: Resource = load("res://assets/card_icons/james_target_icon.png")
var harry_target_texture: Resource = load("res://assets/card_icons/harry_target_icon.png")

var move_symbol = preload("res://scenes/moveSymbol.tscn")

#Colours
enum colours {RED = 0, YELLOW = 1, GREEN = 2, BLUE = 3, ITEM = 4, CHANGE = 5}

var red_rgb: Color = Color(1.0, 0.15, 0.2, 1.0)
var yellow_rgb: Color = Color(0.97, 0.97, 0.1, 1.0)
var green_rgb: Color = Color(0.0, 0.9, 0.2, 1.0)
var blue_rgb: Color = Color(0.2, 0.4, 1.0, 1.0)

var red_icon = load("res://assets/card_icons/red_icon.png")
var yellow_icon = load("res://assets/card_icons/yellow_icon.png")
var green_icon = load("res://assets/card_icons/green_icon.png")
var blue_icon = load("res://assets/card_icons/blue_icon.png")

# HP, Attack, Coin, X & Reroll Icons
var hp_icon: Resource = load("res://assets/card_icons/HP_icon.png")
var attack_icon: Resource = load("res://assets/card_icons/attack_icon.png")
var coin_icon: Resource = load("res://assets/card_icons/cost_icon.png")
var x_icon: Resource = load("res://assets/card_icons/x_icon.png")
var reroll_icon: Resource = load("res://assets/card_icons/reroll_icon.png")
var wins_icon: Resource = load("res://assets/card_icons/win_icon.png")

var minus_icon: Resource = load("res://assets/card_icons/minus_icon.png")
var plus_icon: Resource = load("res://assets/card_icons/plus_icon.png")
var upgrade_icon: Resource = load("res://assets/card_icons/upgrade_icon.png")

enum catagories {NONE = 0, TABLETOP_GAMES = 1, TOWN_OF_SALEM = 2, SPORT_AND_EXERCISE = 3, VIDEO_GAMES = 4, PARENTS = 5, SIBLINGS = 6, MAXMORPHEDS = 7, SONGS_MUSICIANS_INSTRUMENTS = 8, FOOD_AND_DRINK = 9, TEACHERS = 10, SUPER_SMASH_BROS = 11, SCHMERLOCK = 12, DOG = 13}

# CARD STATS
# Variables
@export_group("Stats")
@export var card_name: String
@export var cost: int
@export var hp: int
@export var attack: int
@export var x: int
@export var target: targets
@export var colour: colours
@export_multiline var ability: String
@export_multiline var upgradedAbility: String

@export var n: int

@export var catagory: catagories

@export var upgraded: bool

# Nodes
@onready var background = $background
@onready var name_text = $text/name
@onready var cost_text = $text/cost
@onready var hp_text = $text/hp
@onready var attack_text = $text/attack
@onready var x_text = $text/x
@onready var target_icon = $stats_box/target
@onready var ability_text = $text/ability

@onready var item_name_text = $item_text/name
@onready var item_cost_text = $item_text/cost
@onready var item_ability_text = $item_text/ability

@onready var swing_timer = $swing_time
@onready var proc_timer = $proc_timer
@onready var proc_timer_cooldown = $proc_timer_cooldown

# OTHER VARIABLES
# Drag & Drop
var selected: bool = false
var rest_point
var rest_nodes = []
var temp_rest_point

# Grow & Shrink
var grow: bool = false
var shrink: bool = false
var shrinkDelay:int = 0
var grow_size = 2
var shrink_size = 1

# Item & Ability Effects
@export var reduceX = 0
@export var swapATKandX = 0
@export var blocked_ability: bool
var shopScene
@export var reduce_attack = 0

# Other
@export var inShop: bool
@export var inBattle: bool
@export var inMenu: bool
@export var leader: bool
@export var item_targets: int = 1
var active: bool = false
var teamSlot: int
var locked: bool = false
@onready var lock_sprite = $lock
var textToWrite
@export var targets_order = []
var next_target = 0
var this_x
const NORTH = 0
const EAST = 1
const SOUTH = 2
const WEST = 3
var swing_directions = [false, false, false, false]
var start_pos
var rest_z_index = 0
var starting_fighting_slot
@export var team_number: int

var multi_item_failsafe = 0

# CARD SPECIFIC VARIABLES
@export var choices = []
@export var options = []
@export var attack_order = []
@export var attack_order_possibilities = []
@export var block_order = []
@export var colour_order = []
@export var this_colour: colours
@export var didnt_win_last_battle: bool
@export var target_teams = []
@export var possible_target_teams = []
@export var random_choices = []
@export var target_order = []
@export var this_target: targets
@export var choice: String
@export var colour_order2 = []
@export var this_colour2: colours
@export var possible_index = []

# SET UP
func _ready():
	# Set Colour
	setColour()
	
	# Set Name, Ability & Stats Text
	setStatText()
	if colour == colours.ITEM:
		ability_text = item_ability_text
		rest_z_index = 5
		item_cost_text.position = Vector2(-260, -365)
		item_name_text.position = Vector2(-210, -80)
		ability_text.position = Vector2(-210, 0)
		if card_name == "Classic Of Mice And Men DVD":
			ability_text.position = Vector2(-210, 50)
	setAbilityText()
	
	# Set Target
	setTarget()
	
	# Other
	rest_nodes = get_tree().get_nodes_in_group("zone")
	if rest_nodes.size() > 0 and rest_point == null and not (inBattle or inMenu):
		findClosestRestNode()
	this_x = x
	start_pos = global_position
	if not inShop and not inBattle:
		gather_fighting_info()
	shopScene = get_tree().get_first_node_in_group("shop")

func setColour():
	if colour == colours.CHANGE:
		while colour == colours.CHANGE or colour == colours.ITEM:
			colour = colours.values().pick_random()
	match colour:
		colours.RED:
			background.modulate = red_rgb
		colours.YELLOW:
			background.modulate = yellow_rgb
		colours.GREEN:
			background.modulate = green_rgb
		colours.BLUE:
			background.modulate = blue_rgb
		colours.ITEM:
			background.modulate = Color(0.9, 0.6, 0.2)

func setStatText():
	if colour == colours.ITEM:
		item_name_text.text = card_name
		item_cost_text.text = str(cost)
	else:
		if upgraded:
			name_text.text = card_name + "+"
		else:
			name_text.text = card_name
		cost_text.text = str(cost)
		hp_text.text = str(hp)
		attack_text.text = str(attack)
		x_text.text = str(x)

func setAbilityText():
	ability_text.clear()
	ability_text.text = ""
	if upgraded:
		textToWrite = upgradedAbility
	else:
		textToWrite = ability
	if textToWrite == "":
		blocked_ability = true
	else:
		blocked_ability = false
	ability_text.append_text("[center]")
	for word in textToWrite.split(" "):
		if word == "attack":
			ability_text.add_image(attack_icon, 40, 40)
		elif word == "hp":
			ability_text.add_image(hp_icon, 40, 40)
		elif word == "coin":
			ability_text.add_image(coin_icon, 40, 40)
		elif word == "X":
			ability_text.add_image(x_icon, 34, 34)
		elif word == "reroll_icon":
			ability_text.add_image(reroll_icon, 40, 40)
		elif word == "wins_icon":
			ability_text.add_image(wins_icon, 40, 40)
		elif word.to_lower() == "red":
			ability_text.append_text("[color=#dd1122]"+word+"[/color]")
		elif word.to_lower() == "yellow":
			ability_text.append_text("[color=#aa9900]"+word+"[/color]")
		elif word.to_lower() == "green":
			ability_text.append_text("[color=#00aa11]"+word+"[/color]")
		elif word.to_lower() == "blue":
			ability_text.append_text("[color=#2244ee]"+word+"[/color]")
		elif word == "(N)":
			ability_text.add_text("(" + str(n) + ")")
		elif word == "MATT":
			ability_text.add_image(matt_target_texture, 128, 128)
		elif word == "JOSH":
			ability_text.add_image(josh_target_texture, 128, 128)
		elif word == "JAMES":
			ability_text.add_image(james_target_texture, 128, 128)
		elif word == "HARRY":
			ability_text.add_image(harry_target_texture, 128, 128)
		elif word == "MOST_WINS":
			ability_text.add_image(most_wins_target_texture, 42, 42)
		else:
			ability_text.add_text(word)
		ability_text.add_text(" ")

func setTarget():
	match target:
		targets.CLOCKWISE:
			target_icon.texture = clockwise_target_texture
		targets.RANDOM:
			target_icon.texture = random_target_texture
		targets.MOST_HP:
			target_icon.texture = most_hp_target_texture
		targets.LEAST_HP:
			target_icon.texture = least_hp_target_texture
		targets.MOST_ATTACK:
			target_icon.texture = most_attack_target_texture
		targets.LEAST_ATTACK:
			target_icon.texture = least_attack_target_texture
		targets.MOST_WINS:
			target_icon.texture = most_wins_target_texture
		targets.LEAST_WINS:
			target_icon.texture = least_wins_target_texture
		targets.MATT:
			target_icon.texture = matt_target_texture
		targets.JOSH:
			target_icon.texture = josh_target_texture
		targets.JAMES:
			target_icon.texture = james_target_texture
		targets.HARRY:
			target_icon.texture = harry_target_texture

func _physics_process(delta):
	if selected and not (inBattle or inMenu):
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	elif rest_nodes.size() > 0 and rest_point != null and not (inBattle or inMenu):
		global_position = lerp(global_position, rest_point.global_position, 10 * delta)
	if swing_directions[NORTH]:
		global_position.y -= 4000 * delta
	if swing_directions[EAST]:
		global_position.x += 4000 * delta
	if swing_directions[SOUTH]:
		global_position.y += 4000 * delta
	if swing_directions[WEST]:
		global_position.x -= 4000 * delta
	if not (true in swing_directions) and active:
		global_position = lerp(global_position, start_pos, 12 * delta)
	if grow:
		if self.scale.x >= grow_size:
			grow = false
			self.scale.x = grow_size
			self.scale.y = grow_size
			lock_sprite.modulate.a = 0.4
		else:
			self.scale *= 1 + (10 * delta)
	elif shrink:
		if self.scale.x <= shrink_size:
			shrink = false
			self.scale.x = shrink_size
			self.scale.y = shrink_size
			lock_sprite.modulate.a = 1
			z_index = rest_z_index
		else:
			self.scale *= 1 - (10 * delta)
	elif shrinkDelay == 1:
		shrinkDelay = 0
		shrink = true
	elif shrinkDelay > 0:
		shrinkDelay -= 1

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click") and not (inBattle or leader):
		pick_up_card()
	elif Input.is_action_just_pressed("click") and inMenu:
		Manager.leaderName = card_name

func _input(event):
	if event is InputEventMouseButton and not (inBattle or leader):
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and selected:
			put_down_card()

func put_down_card():
	selected = false
	Manager.holdingCard = false
	await findClosestRestNode()

func findClosestRestNode():
	var shortest_distance = INF
	var target_point = rest_nodes[0]
	for child in rest_nodes:
		if child.card == null and colour != colours.ITEM:
			var distance = global_position.distance_squared_to(child.global_position)
			if distance < shortest_distance and ((child.type == child.types.TEAM and distance < 320000) or (child.type == child.types.SELL and distance < 80000 and card_name != "The Beatles") or (child.type == child.types.LOCK and distance < 80000) or (child.type == child.types.UPGRADE and distance < 80000 and not upgraded and cost <= Manager.money)):
				target_point = child
				shortest_distance = distance
		elif colour == colours.ITEM and (child.type == child.types.TEAM and child.card != null) or child.type == child.types.LOCK:
			var distance = global_position.distance_squared_to(child.global_position)
			if distance < shortest_distance and ((child.type == child.types.TEAM and distance < 320000) or (child.type == child.types.LOCK and distance < 80000)):
				target_point = child
				shortest_distance = distance
	if colour == colours.ITEM:
		if target_point.type == target_point.types.TEAM and cost <= Manager.money:
			await Manager.update_friends()
			rest_point.card = null
			Manager.money -= cost
			rest_point.shopScene.updateText()
			visible = false
			await item_bought(target_point.card)
			rest_point.shopScene.updateText()
			queue_free()
		elif target_point.type == target_point.types.LOCK:
			rest_point = temp_rest_point
			rest_point.card = self
			if locked:
				locked = false
				lock_sprite.visible = false
			else:
				locked = true
				lock_sprite.visible = true
	elif target_point.type == target_point.types.TEAM and target_point.slotNum != 0 and not inShop:
		target_point.card = self
		if rest_point != null:
			if rest_point.card == self:
				rest_point.card = null
		rest_point = target_point
	elif target_point.type == target_point.types.TEAM and cost <= Manager.money and target_point.slotNum != 0:
		target_point.card = self
		rest_point.card = null
		rest_point = target_point
		Manager.money -= cost
		inShop = false
		locked = false
		lock_sprite.visible = false
		rest_point.shopScene.updateText()
		buy()
		await Manager.card_bought(self)
		await Manager.card_summoned(team_number, self)
	elif target_point.type == target_point.types.SELL and shortest_distance < 80000 and not inShop and card_name != "The Beatles":
		if rest_point != null:
			if rest_point.card == self:
				rest_point.card = null
		rest_point = target_point
		await sell()
		Manager.money += int(cost / 2)
		rest_point.shopScene.updateText()
		if int(cost / 2) > 0:
			Manager.move_symbol(global_position, shopScene.money_img.global_position, coin_icon, str(int(cost / 2)))
		visible = false
		await Manager.card_sold(self)
		queue_free()
	elif target_point.type == target_point.types.LOCK and shortest_distance < 80000 and inShop:
		rest_point = temp_rest_point
		rest_point.card = self
		if locked:
			locked = false
			lock_sprite.visible = false
		else:
			locked = true
			lock_sprite.visible = true
	elif target_point.type == target_point.types.UPGRADE and shortest_distance < 80000 and not inShop and not upgraded and cost <= Manager.money:
		rest_point = temp_rest_point
		rest_point.card = self
		rest_point.shopScene.upgradeScene(self)
	elif temp_rest_point != null:
		rest_point = temp_rest_point
		if rest_point.card != self:
			for node in rest_nodes:
				if node.type == node.types.TEAM and node.card == null:
					var distance = global_position.distance_squared_to(node.global_position)
					if distance < shortest_distance:
						target_point = node
						shortest_distance = distance
			target_point.card = self
			if rest_point != null:
				if rest_point.card == self:
					rest_point.card = null
			rest_point = target_point
		rest_point.card = self

func _on_area_2d_mouse_entered():
	if not Manager.holdingCard:
		grow = true
		z_index += 1

func _on_area_2d_mouse_exited():
	shrinkDelay = 3

func _on_ability_mouse_entered():
	shrinkDelay = 0

func _on_ability_gui_input(_event):
	if Input.is_action_just_pressed("click") and not (inBattle or leader):
		pick_up_card()
	elif Input.is_action_just_pressed("click") and inMenu:
		Manager.leaderName = card_name

func pick_up_card():
	if not colour == colours.ITEM:
		Manager.holdingCard = true
	selected = true
	shrinkDelay = 3
	if rest_point != null:
		temp_rest_point = rest_point
		if rest_point.type != rest_point.types.FRIEND_SHOP and rest_point.type != rest_point.types.ITEM_SHOP:
			rest_point.card = null
			rest_point = null

func gather_fighting_info():
	var target_possibilities = [1, 2, 3, 4]
	for i in range ((x + 7) * (hp + 7)):
		if i >= Manager.playerNum - 1:
			match target:
				targets.CLOCKWISE:
					targets_order.append(target_possibilities[i % 4])
				_:
					targets_order.append(target_possibilities.pick_random())
	await card_specific_rng()
	if rest_point != null:
		Manager.friends[abs(rest_point.slotNum - 5)] = self

func attack_swing(direction):
	swing_timer.start()
	match direction:
		"N":
			swing_directions[NORTH] = true
		"E":
			swing_directions[EAST] = true
		"S":
			swing_directions[SOUTH] = true
		"W":
			swing_directions[WEST] = true
		"NE":
			swing_directions[NORTH] = true
			swing_directions[EAST] = true
		"SE":
			swing_directions[SOUTH] = true
			swing_directions[EAST] = true
		"NW":
			swing_directions[NORTH] = true
			swing_directions[WEST] = true
		"SW":
			swing_directions[SOUTH] = true
			swing_directions[WEST] = true

func find_target_icon(target_to_find):
	var target_icon_found
	match target_to_find:
		targets.CLOCKWISE:
			target_icon_found = clockwise_target_texture
		targets.RANDOM:
			target_icon_found = random_target_texture
		targets.MOST_HP:
			target_icon_found = most_hp_target_texture
		targets.LEAST_HP:
			target_icon_found = least_hp_target_texture
		targets.MOST_ATTACK:
			target_icon_found = most_attack_target_texture
		targets.LEAST_ATTACK:
			target_icon_found = least_attack_target_texture
		targets.MOST_WINS:
			target_icon_found = most_wins_target_texture
		targets.LEAST_WINS:
			target_icon_found = least_wins_target_texture
		targets.MATT:
			target_icon_found = matt_target_texture
		targets.JOSH:
			target_icon_found = josh_target_texture
		targets.JAMES:
			target_icon_found = james_target_texture
		targets.HARRY:
			target_icon_found = harry_target_texture
	return target_icon_found

func find_colour_icon(colour_to_find):
	var colour_icon_found
	match colour_to_find:
		colours.RED:
			colour_icon_found = red_icon
		colours.YELLOW:
			colour_icon_found = yellow_icon
		colours.GREEN:
			colour_icon_found = green_icon
		colours.BLUE:
			colour_icon_found = blue_icon
	return colour_icon_found

func start_turn():
	pass

func buy():
	pass

func buy_card(_card):
	pass

func friend_summoned(_friend):
	pass

func sell():
	pass

func sell_card(_colour, _cost):
	pass

func use_item():
	pass

func friend_uses_item(_friend):
	pass

func reroll():
	pass

func end_turn():
	pass

func start_battle():
	pass

func friend_dies(_dead_friend_catagory):
	pass

func friend_ahead_attacks(_friend):
	pass

func before_attack():
	pass

func after_attack():
	pass

func kill(_dead_team, _dead_team_index):
	pass

func hurt(_attacker):
	pass

func enemy_summoned(_enemy):
	pass

func die(_killers):
	pass

func card_specific_rng():
	pass

func item_ability(_target_friend):
	pass

var friends_using_item = []
var this_friend_using_item
func item_bought(target_friend):
	if item_targets == 1:
		await item_ability(target_friend)
		await Manager.item_used(target_friend)
	elif item_targets == 0:
		await item_ability(target_friend)
	else:
		await Manager.update_friends()
		friends_using_item.clear()
		for i in range(min(item_targets, (6 - Manager.friends.count(null)))):
			this_friend_using_item = null
			multi_item_failsafe = 0
			while this_friend_using_item in friends_using_item or this_friend_using_item == null:
				multi_item_failsafe += 1
				if Manager.prioritise_leader and Manager.friends[0] not in friends_using_item:
					this_friend_using_item = Manager.friends[0]
				else:
					this_friend_using_item = Manager.friends.pick_random()
				if multi_item_failsafe >= 100:
					break
			friends_using_item.append(this_friend_using_item)
		for card in friends_using_item:
			await item_ability(card)
		for card in friends_using_item:
			await Manager.item_used(card)

func _on_swing_time_timeout():
	swing_directions = [false, false, false, false]

func proc():
	grow = true
	z_index += 1
	proc_timer.wait_time = 0.8
	proc_timer_cooldown.wait_time = 0.2
	proc_timer.start()
	await proc_timer.timeout
	shrink = true
	z_index = rest_z_index
	proc_timer_cooldown.start()
	await proc_timer_cooldown.timeout

func quick_proc():
	grow = true
	z_index += 1
	proc_timer.wait_time = 0.4
	proc_timer_cooldown.wait_time = 0.1
	proc_timer.start()
	await proc_timer.timeout
	shrink = true
	z_index = rest_z_index
	proc_timer_cooldown.start()
	await proc_timer_cooldown.timeout

func attack_opponent(opponent, damage_to_deal, arena_scene):
	opponent.hp -= damage_to_deal
	await Manager.move_symbol(global_position, opponent.global_position, attack_icon, str(damage_to_deal))
	await get_tree().create_timer(0.2).timeout
	await opponent.hurt(self)
	if opponent.hp <= 0:
		match team_number:
			1:
				arena_scene.p1stats[arena_scene.MONEY] += 1
				arena_scene.activate_kill_and_die_stuff(self, opponent, opponent.team_number)
				await Manager.move_symbol(opponent.global_position, arena_scene.coin_icons[team_number - 1].global_position, arena_scene.coin_symbol, "")
			2:
				arena_scene.p2stats[arena_scene.MONEY] += 1
				arena_scene.activate_kill_and_die_stuff(self, opponent, opponent.team_number)
				await Manager.move_symbol(opponent.global_position, arena_scene.coin_icons[team_number - 1].global_position, arena_scene.coin_symbol, "")
			3:
				arena_scene.p3stats[arena_scene.MONEY] += 1
				arena_scene.activate_kill_and_die_stuff(self, opponent, opponent.team_number)
				await Manager.move_symbol(opponent.global_position, arena_scene.coin_icons[team_number - 1].global_position, arena_scene.coin_symbol, "")
			4:
				arena_scene.p4stats[arena_scene.MONEY] += 1
				arena_scene.activate_kill_and_die_stuff(self, opponent, opponent.team_number)
				await Manager.move_symbol(opponent.global_position, arena_scene.coin_icons[team_number - 1].global_position, arena_scene.coin_symbol, "")
		match opponent.team_number:
			1:
				if arena_scene.p1cards.size() > 1:
					for i in range(1, arena_scene.p1cards.size()):
						arena_scene.card_proc_order_backup.append([arena_scene.p1cards[i], opponent.catagory])
			2:
				if arena_scene.p2cards.size() > 1:
					for i in range(1, arena_scene.p2cards.size()):
						arena_scene.card_proc_order_backup.append([arena_scene.p2cards[i], opponent.catagory])
			3:
				if arena_scene.p3cards.size() > 1:
					for i in range(1, arena_scene.p3cards.size()):
						arena_scene.card_proc_order_backup.append([arena_scene.p3cards[i], opponent.catagory])
			4:
				if arena_scene.p4cards.size() > 1:
					for i in range(1, arena_scene.p4cards.size()):
						arena_scene.card_proc_order_backup.append([arena_scene.p4cards[i], opponent.catagory])

func new_card_summoned(team, new_card):
	var arena_scene = get_tree().get_first_node_in_group("arena")
	for opponent in arena_scene.p1cards:
		if opponent.card_name != "ghost" and opponent.hp > 0:
			if opponent.team_number == team:
				await opponent.friend_summoned(new_card)
			else:
				await opponent.enemy_summoned(new_card)
	for opponent in arena_scene.p2cards:
		if opponent.card_name != "ghost" and opponent.hp > 0:
			if opponent.team_number == team:
				await opponent.friend_summoned(new_card)
			else:
				await opponent.enemy_summoned(new_card)
	for opponent in arena_scene.p3cards:
		if opponent.card_name != "ghost" and opponent.hp > 0:
			if opponent.team_number == team:
				await opponent.friend_summoned(new_card)
			else:
				await opponent.enemy_summoned(new_card)
	for opponent in arena_scene.p4cards:
		if opponent.card_name != "ghost" and opponent.hp > 0:
			if opponent.team_number == team:
				await opponent.friend_summoned(new_card)
			else:
				await opponent.enemy_summoned(new_card)
