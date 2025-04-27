extends Sprite2D

var rng = RandomNumberGenerator.new()

@onready var shopScene = $".."

enum types {TEAM = 0, FRIEND_SHOP = 1, ITEM_SHOP = 2, LOCK = 3, SELL = 4, UPGRADE = 5}

var card = null
var possible_card = null
@export var slotNum: int
@export var type: types
@export var active: bool = true
var rest_nodes = []
var teamSlots = [null, null, null, null, null, null]

func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")
	for slot in rest_nodes:
		if slot.type == types.TEAM:
			teamSlots[slot.slotNum] = slot

func _process(_delta):
	if active:
		if type == types.FRIEND_SHOP and card == null:
			possible_card = Manager.all_friends[rng.randi_range(0, (Manager.all_friends.size() - 1))].instantiate()
			#while (possible_card.cost > (Manager.round * 3) and Manager.round != 0) or (possible_card.card_name == "3 Of Clubs" and Manager.round < 3):
			while possible_card.card_name != "The Enigma" and rng.randf() < 0.99:
				possible_card = Manager.all_friends[rng.randi_range(0, (Manager.all_friends.size() - 1))].instantiate()
			card = possible_card.duplicate()
			card.global_position = global_position
			card.rest_point = self
			card.inShop = true
			card.hp += Manager.shop_friend_hp_buff
			card.attack += Manager.shop_friend_attack_buff
			shopScene.add_child(card)
		elif type == types.ITEM_SHOP and card == null:
			possible_card = Manager.all_items[rng.randi_range(0, (Manager.all_items.size() - 1))].instantiate()
			while (possible_card.cost > Manager.round * 3 and Manager.round != 0) or (Manager.prioritise_leader and possible_card.cost < 9):
			#while possible_card.card_name != "Cannibal" and rng.randf() < 0.99:
				possible_card = Manager.all_items[rng.randi_range(0, (Manager.all_items.size() - 1))].instantiate()
			card = possible_card.duplicate()
			card.global_position = global_position
			card.rest_point = self
			card.inShop = true
			shopScene.add_child(card)

func _on_area_2d_mouse_entered():
	if type == types.TEAM and Manager.holdingCard and card != null and slotNum != 0:
		var nearestEmpty = 0
		var distFromEmpty = 5
		var moveDirection = "left"
		for slot in teamSlots:
			if slot.card == null and slot.slotNum != 0:
				if abs(slotNum - slot.slotNum) < distFromEmpty:
					distFromEmpty = abs(slotNum - slot.slotNum)
					nearestEmpty = slot.slotNum
		if nearestEmpty > 0:
			if nearestEmpty > slotNum:
				moveDirection = "right"
			moveCard(moveDirection)

func moveCard(dir):
	if dir == "left":
		if teamSlots[slotNum - 1].card != null:
			teamSlots[slotNum - 1].moveCard("left")
		teamSlots[slotNum - 1].card = card
		card.rest_point = teamSlots[slotNum - 1]
		card = null
	else:
		if teamSlots[slotNum + 1].card != null:
			teamSlots[slotNum + 1].moveCard("right")
		teamSlots[slotNum + 1].card = card
		card.rest_point = teamSlots[slotNum + 1]
		card = null
