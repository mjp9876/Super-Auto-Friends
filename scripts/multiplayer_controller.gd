extends Node2D


@export var Address = "127.0.0.1"
@export var port = 7777
var peer

@onready var cam_object = $Camera2D
@onready var start_button = $start_game
@onready var create_button = $create_game
@onready var join_button = $join_game

@onready var address_textline = $enter_address
@onready var address_text = $adress_text
@onready var wins_text = $wins

@onready var tokens = [$tokenP1, $tokenP2, $tokenP3, $tokenP4]

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)




func peer_connected(_id):
	#print("player connected " + str(id))
	add_token.rpc()

func peer_disconnected(id):
	print("player disconnected " + str(id))

func connected_to_server():
	#print("connected to server")
	send_player_information.rpc_id(1, multiplayer.get_unique_id())

func connection_failed():
	print("connection failed")

func _on_create_game_pressed():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 4)
	if error != OK:
		print("Cannot host: " + str(error))
		return
	
	multiplayer.set_multiplayer_peer(peer)
	# upnp_setup()
	print("Waiting for Players...")
	start_button.visible = true
	create_button.visible = false
	join_button.visible = false
	address_textline.visible = false
	wins_text.visible = true
	add_token()
	send_player_information(multiplayer.get_unique_id())


func _on_join_game_pressed():
	if address_textline.text != "":
		Address = address_textline.text
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address, port)
	multiplayer.set_multiplayer_peer(peer)
	create_button.visible = false
	join_button.visible = false
	address_textline.visible = false

var wins
func _on_start_game_pressed():
	wins = int(wins_text.text)
	start_game.rpc(wins)


@rpc("any_peer", "call_local")
func start_game(wins_to_win):
	Manager.victory_wins = wins_to_win
	var scene = load("res://scenes/main.tscn").instantiate()
	get_tree().root.add_child(scene)
	cam_object.enabled = false
	self.hide()

@rpc("any_peer")
func send_player_information(id):
	if not Manager.players.has(id):
		Manager.players[id] = { "id": id }
	if multiplayer.is_server():
		for i in Manager.players:
			send_player_information.rpc(i)

@rpc("any_peer")
func add_token():
	if Manager.players.size() > 0:
		tokens[0].visible = true
	if Manager.players.size() > 1:
		tokens[1].visible = true
	if Manager.players.size() > 2:
		tokens[2].visible = true
	if Manager.players.size() > 3:
		tokens[3].visible = true


func upnp_setup():
	var upnp = UPNP.new()
	
	var discover_result = upnp.discover()
	assert(discover_result == UPNP.UPNP_RESULT_SUCCESS, \
		"UPNP Discover Failed! Error %s" % discover_result)

	assert(upnp.get_gateway() and upnp.get_gateway().is_valid_gateway(), \
		"UPNP Invalid Gateway!")

	var map_result = upnp.add_port_mapping(port)
	assert(map_result == UPNP.UPNP_RESULT_SUCCESS, \
		"UPNP Port Mapping Failed! Error %s" % map_result)
	
	print("Success! Join Address: %s" % upnp.query_external_address())
	address_text.text = str(upnp.query_external_address())
