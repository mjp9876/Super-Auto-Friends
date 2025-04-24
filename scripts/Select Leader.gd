extends Node2D

@onready var tokens = [$tokenP1, $tokenP2, $tokenP3, $tokenP4]
@onready var matt_card = $"Matt Phillips"
@onready var josh_card = $Josh
@onready var james_card = $James
@onready var harry_card = $Harry

@onready var main = $".."
@onready var shop = $"../GameShop"

@onready var start_button = $Control/ready

@export var arena: PackedScene

var inMenu = true
var first_spawn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Manager.playerNum = Manager.players.values().find({ "id": multiplayer.get_unique_id()}) + 1
	if Manager.playerNum != 1:
		start_button.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if inMenu:
		match Manager.leaderName:
			"Matt Phillips":
				move_token.rpc(Manager.playerNum, matt_card.global_position, matt_card.scale)
			"Josh":
				move_token.rpc(Manager.playerNum, josh_card.global_position, josh_card.scale)
			"James":
				move_token.rpc(Manager.playerNum, james_card.global_position, james_card.scale)
			"Harry":
				move_token.rpc(Manager.playerNum, harry_card.global_position, harry_card.scale)
	if not first_spawn and Manager.ready_players == 4:
		await put_leader_in_shop()
		await assign_friends()
		var areana = arena.instantiate()
		main.add_child(areana)
		first_spawn = true

@rpc("any_peer", "call_local")
func move_token(num, card_pos, card_scale):
	tokens[num - 1].global_position = Vector2(card_pos.x + (((num % 2) - 0.5) * (-400 * card_scale.x)), card_pos.y + ((((num - 1) / 2) - 0.5) * (600 * card_scale.y)))

func _on_ready_pressed():
	start_game.rpc()

@rpc("any_peer", "call_local")
func start_game():
	inMenu = false
	matt_card.inMenu = false
	josh_card.inMenu = false
	james_card.inMenu = false
	harry_card.inMenu = false
	visible = false
	Manager.ready_players = 4

func assign_friends():
	match Manager.playerNum:
		1:
			Manager.teamP1 = Manager.friends
		2:
			Manager.teamP2 = Manager.friends
		3:
			Manager.teamP3 = Manager.friends
		4:
			Manager.teamP4 = Manager.friends
	Manager.money = 10
	Manager.wins = 0
	Manager.round = 0


func put_leader_in_shop():
	var teamLeaderSlot = shop.find_child("leaderSlot")
	match Manager.leaderName:
		"Matt Phillips":
			Manager.friends[5] = matt_card
			matt_card.reparent(shop)
			matt_card.rest_point = teamLeaderSlot
			teamLeaderSlot.card = matt_card
		"Josh":
			Manager.friends[5] = josh_card
			josh_card.reparent(shop)
			josh_card.rest_point = teamLeaderSlot
			teamLeaderSlot.card = josh_card
		"James":
			Manager.friends[5] = james_card
			james_card.reparent(shop)
			james_card.rest_point = teamLeaderSlot
			teamLeaderSlot.card = james_card
		"Harry":
			Manager.friends[5] = harry_card
			harry_card.reparent(shop)
			harry_card.rest_point = teamLeaderSlot
			teamLeaderSlot.card = harry_card
