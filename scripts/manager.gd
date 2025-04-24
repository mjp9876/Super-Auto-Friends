extends Node

var rng = RandomNumberGenerator.new()

var move_symbol_scene = preload("res://scenes/moveSymbolTake2.tscn")
var coin_icon = preload("res://assets/card_icons/cost_icon.png")

# ALL FRIENDS AND ITEMS
var all_friends = [preload("res://scenes/classic_matt_phillips_jumper.tscn"), preload("res://scenes/3_of_clubs.tscn"), preload("res://scenes/4_chess.tscn"), preload("res://scenes/acapella.tscn"), preload("res://scenes/alice.tscn"), preload("res://scenes/alike_seamen.tscn"), preload("res://scenes/ambassador.tscn"), preload("res://scenes/amnesiac.tscn"), preload("res://scenes/andres.tscn"), preload("res://scenes/annie.tscn"), preload("res://scenes/archie.tscn"), preload("res://scenes/assassin.tscn"), preload("res://scenes/badminton.tscn"), preload("res://scenes/balatro.tscn"), preload("res://scenes/barbara.tscn"), preload("res://scenes/barry.tscn"), preload("res://scenes/basketball.tscn"), preload("res://scenes/becky.tscn"), preload("res://scenes/ben.tscn"), preload("res://scenes/blue_baby.tscn"), preload("res://scenes/blue_guru_maxmorphed_.tscn"), preload("res://scenes/bohemian_rhapsody.tscn"), preload("res://scenes/bristol.tscn"), preload("res://scenes/callum.tscn"), preload("res://scenes/cameraman.tscn"), preload("res://scenes/captain.tscn"), preload("res://scenes/captain_morgans.tscn"), preload("res://scenes/catan.tscn"), preload("res://scenes/charterstone.tscn"), preload("res://scenes/clare.tscn"), preload("res://scenes/clever_trevor.tscn"), preload("res://scenes/connor.tscn"), preload("res://scenes/consort.tscn"), preload("res://scenes/contessa.tscn"), preload("res://scenes/cool_maxmorphed_.tscn"), preload("res://scenes/cowey.tscn"), preload("res://scenes/craftyotter.tscn"), preload("res://scenes/dan.tscn"), preload("res://scenes/darron.tscn"), preload("res://scenes/david_bentley.tscn"), preload("res://scenes/deal_breaker.tscn"), preload("res://scenes/death_money.tscn"), preload("res://scenes/diamond_thief.tscn"), preload("res://scenes/discord.tscn"), preload("res://scenes/doctor.tscn"), preload("res://scenes/dodgeball.tscn"), preload("res://scenes/dog_food.tscn"), preload("res://scenes/drums.tscn"), preload("res://scenes/drunk.tscn"), preload("res://scenes/dr_haddock.tscn"), preload("res://scenes/dr_schlotson.tscn"), preload("res://scenes/duke.tscn"), preload("res://scenes/durham.tscn"), preload("res://scenes/eden.tscn"), preload("res://scenes/edie.tscn"), preload("res://scenes/ed_sheeran.tscn"), preload("res://scenes/ella.tscn"), preload("res://scenes/elle_fanning.tscn"), preload("res://scenes/emma.tscn"), preload("res://scenes/emoji_maxmorphed_.tscn"), preload("res://scenes/esme.tscn"), preload("res://scenes/esme_edwards.tscn"), preload("res://scenes/esme_foster.tscn"), preload("res://scenes/eu_4.tscn"), preload("res://scenes/eve.tscn"), preload("res://scenes/evie.tscn"), preload("res://scenes/fedora.tscn"), preload("res://scenes/florence_pugh.tscn"), preload("res://scenes/fred.tscn"), preload("res://scenes/gingerbread_man.tscn"), preload("res://scenes/godfather.tscn"), preload("res://scenes/grace_full.tscn"), preload("res://scenes/greggs.tscn"), preload("res://scenes/guitar.tscn"), preload("res://scenes/gus.tscn"), preload("res://scenes/haddock.tscn"), preload("res://scenes/hamilton.tscn"), preload("res://scenes/harry_potter_maxmorphed_.tscn"), preload("res://scenes/hattie.tscn"), preload("res://scenes/hobbes.tscn"), preload("res://scenes/illegally_blonde.tscn"), preload("res://scenes/isaac.tscn"), preload("res://scenes/i_prefer_contactless.tscn"), preload("res://scenes/january_5_th.tscn"), preload("res://scenes/jayshade_.tscn"), preload("res://scenes/jas.tscn"), preload("res://scenes/jester.tscn"), preload("res://scenes/joel.tscn"), preload("res://scenes/keyboard.tscn"), preload("res://scenes/kidney.tscn"), preload("res://scenes/killer_klown.tscn"), preload("res://scenes/king_de_de_de.tscn"), preload("res://scenes/kirby.tscn"), preload("res://scenes/leonardo_di_caprio.tscn"), preload("res://scenes/leslie.tscn"), preload("res://scenes/lewis_rainton.tscn"), preload("res://scenes/lily_james.tscn"), preload("res://scenes/lizzie.tscn"), preload("res://scenes/loki.tscn"), preload("res://scenes/lottie.tscn"), preload("res://scenes/luci.tscn"), preload("res://scenes/luke_skywalker.tscn"), preload("res://scenes/mallard.tscn"), preload("res://scenes/martha.tscn"), preload("res://scenes/matt_phillips_maxmorphed_.tscn"), preload("res://scenes/maxmorphed_.tscn"), preload("res://scenes/mc_dect_schmalade.tscn"), preload("res://scenes/meal_deal.tscn"), preload("res://scenes/medium.tscn"), preload("res://scenes/minecraft.tscn"), preload("res://scenes/mist.tscn"), preload("res://scenes/molly.tscn"), preload("res://scenes/mr_baybutt.tscn"), preload("res://scenes/mr_boothman.tscn"), preload("res://scenes/mr_fairclough.tscn"), preload("res://scenes/mr_monopoly.tscn"), preload("res://scenes/neil_breen.tscn"), preload("res://scenes/nick.tscn"), preload("res://scenes/old_mout.tscn"), preload("res://scenes/ollie.tscn"), preload("res://scenes/one_cut_of_the_dead.tscn"), preload("res://scenes/oracle.tscn"), preload("res://scenes/pasta_bake.tscn"), preload("res://scenes/pet_vaccine.tscn"), preload("res://scenes/pho_kingdom.tscn"), preload("res://scenes/pichu.tscn"), preload("res://scenes/pikachu.tscn"), preload("res://scenes/poppy.tscn"), preload("res://scenes/queen.tscn"), preload("res://scenes/rae_&_webb.tscn"), preload("res://scenes/robber.tscn"), preload("res://scenes/robert.tscn"), preload("res://scenes/sackable_offense.tscn"), preload("res://scenes/sagrada.tscn"), preload("res://scenes/sam.tscn"), preload("res://scenes/samson.tscn"), preload("res://scenes/schmerlock.tscn"), preload("res://scenes/schmirene_adler.tscn"), preload("res://scenes/schmoriarty.tscn"), preload("res://scenes/serial_killer.tscn"), preload("res://scenes/shanebra.tscn"), preload("res://scenes/shiny_008.tscn"), preload("res://scenes/shona.tscn"), preload("res://scenes/simon.tscn"), preload("res://scenes/skribbl_io.tscn"), preload("res://scenes/slap.tscn"), preload("res://scenes/smash_ball.tscn"), preload("res://scenes/snowman_pornstar.tscn"), preload("res://scenes/sophie.tscn"), preload("res://scenes/spaceship.tscn"), preload("res://scenes/starbucks_boyo.tscn"), preload("res://scenes/steven_mc_steven.tscn"), preload("res://scenes/stoke.tscn"), preload("res://scenes/surrey.tscn"), preload("res://scenes/survivor.tscn"), preload("res://scenes/swimming.tscn"), preload("res://scenes/tennis.tscn"), preload("res://scenes/the_beatles.tscn"), preload("res://scenes/the_butler.tscn"), preload("res://scenes/the_butler.tscn"), preload("res://scenes/the_chef.tscn"), preload("res://scenes/the_fox.tscn"), preload("res://scenes/the_iron_throne.tscn"), preload("res://scenes/the_janitor.tscn"), preload("res://scenes/the_keeper.tscn"), preload("res://scenes/the_mountainous_bulge.tscn"), preload("res://scenes/ticket_to_ride.tscn"), preload("res://scenes/tin_can.tscn"), preload("res://scenes/tom_nook.tscn"), preload("res://scenes/troglodyte.tscn"), preload("res://scenes/turd_burglar.tscn"), preload("res://scenes/vet.tscn"), preload("res://scenes/via_macdab.tscn"), preload("res://scenes/werewolf.tscn"), preload("res://scenes/wingspan.tscn")]
var all_items = [preload("res://scenes/51_windmill_rise.tscn"), preload("res://scenes/72_millfield_road.tscn"), preload("res://scenes/alton_towers.tscn"), preload("res://scenes/blue_shell.tscn"), preload("res://scenes/cannibal.tscn"), preload("res://scenes/classic_of_mice_and_men_dvd.tscn"), preload("res://scenes/delorean.tscn"), preload("res://scenes/diss_track.tscn"), preload("res://scenes/dylan's_grill.tscn"), preload("res://scenes/factorio.tscn"), preload("res://scenes/fedora_#2.tscn"), preload("res://scenes/four_souls.tscn"), preload("res://scenes/garlic_bread.tscn"), preload("res://scenes/gartic_phone.tscn"), preload("res://scenes/gay_train.tscn"), preload("res://scenes/horse_girl.tscn"), preload("res://scenes/i'm_matt_phillips.tscn"), preload("res://scenes/i_disagree.tscn"), preload("res://scenes/krunker.tscn"), preload("res://scenes/mung_bean.tscn"), preload("res://scenes/nu_life.tscn"), preload("res://scenes/overcooked.tscn"), preload("res://scenes/pioneer.tscn"), preload("res://scenes/pizza.tscn"), preload("res://scenes/praphaphorn.tscn"), preload("res://scenes/sausage_roll.tscn"), preload("res://scenes/sensations.tscn"), preload("res://scenes/super_auto_pets.tscn"), preload("res://scenes/super_smash_bros.tscn"), preload("res://scenes/sushi_go_party.tscn"), preload("res://scenes/third_layer.tscn"), preload("res://scenes/vomit.tscn"), preload("res://scenes/weed.tscn"), preload("res://scenes/york.tscn"), preload("res://scenes/miss_askew.tscn")]

# ALL PLAYER INFO
var teamP1 = [null, null, null, null, null, null]
var teamP2 = [null, null, null, null, null, null]
var teamP3 = [null, null, null, null, null, null]
var teamP4 = [null, null, null, null, null, null]

var saved_team1 = [null, null, null, null, null, null]
var saved_team2 = [null, null, null, null, null, null]
var saved_team3 = [null, null, null, null, null, null]
var saved_team4 = [null, null, null, null, null, null]

const WINS = 0
const MONEY = 1
const LEADER = 2

var players = {}
var statsP1 = [0, 10, ""]
var statsP2 = [0, 10, ""]
var statsP3 = [0, 10, ""]
var statsP4 = [0, 10, ""]

var rand_floats = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

# PLAYER NUMBER
var playerNum: int
var leaderName: String

# STATS
var money: int
var wins: int

# TEAM
var friends: Array[Node] = [null, null, null, null, null, null]
var team_slots = [null, null, null, null, null, null]

# OTHER
var holdingCard = false

var previous_round_winner = []

var card_proc_order = []

var move_symbols = []

var this_symbol

var round = 0

var item_stat_multiplier: float = 1.0
var prioritise_leader = false
var shop_friend_hp_buff = 0
var shop_friend_attack_buff = 0

var ready_players = 0
var ready_players_tracker = [false, false, false, false]

var victory_wins


# Called when the node enters the scene tree for the first time.
func _ready():
	#all_friends = dir_contents("res://scenes/friends/")
	#all_items = dir_contents("res://scenes/items/")
	find_team_slots()
	this_symbol = move_symbol_scene.instantiate()

func find_team_slots():
	var all_zones = get_tree().get_nodes_in_group("zone")
	for zone in all_zones:
		if zone.type == zone.types.TEAM:
			team_slots[zone.slotNum] = zone

func dir_contents(path):
	var scene_loads = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				if file_name.get_extension() == "tscn":
					var full_path = path.path_join(file_name)
					scene_loads.append(load(full_path))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return scene_loads

func gather_fighting_info_management_style():
	match playerNum:
		1:
			teamP1 = friends.duplicate()
			statsP1 = [wins, money, leaderName]
			for i in range(7):
				rand_floats[i] = rng.randf()
		2:
			teamP2 = friends.duplicate()
			statsP2 = [wins, money, leaderName]
		3:
			teamP3 = friends.duplicate()
			statsP3 = [wins, money, leaderName]
		4:
			teamP4 = friends.duplicate()
			statsP4 = [wins, money, leaderName]

func update_friends():
	item_stat_multiplier = 1.0
	prioritise_leader = false
	for i in range(6):
		if team_slots[i]:
			friends[i] = team_slots[i].card
			if friends[i] != null and friends[i].card_name == "Esme" and not friends[i].blocked_ability and not friends[i].upgraded:
				item_stat_multiplier += 1.0
			elif friends[i] != null and friends[i].card_name == "Esme" and not friends[i].blocked_ability and friends[i].upgraded:
				item_stat_multiplier += 1.5
			if friends[i] != null and friends[i].card_name == "Leslie" and not friends[i].blocked_ability:
				prioritise_leader = true

func kill_friends_in_team():
	for friend in friends:
		if friend != null and friend.hp <= 0:
			await friend.die([])
			await friend_died_in_shop(friend.catagory)
			friend.queue_free()

func sort_hp(a, b):
	if a.hp > b.hp:
		return true
	return false

func activate_cards_start_turn():
	if null in team_slots:
		find_team_slots()
	set_player_teams(1, saved_team1)
	set_player_teams(2, saved_team2)
	set_player_teams(3, saved_team3)
	set_player_teams(4, saved_team4)
	teamP1.reverse()
	teamP2.reverse()
	teamP3.reverse()
	teamP4.reverse()
	for i in range(6):
		match playerNum:
			1:
				if teamP1[i] == null and team_slots[i].card != null:
					team_slots[i].card.queue_free()
				elif teamP1[i] != null and teamP1[i].colour != team_slots[i].card.colour:
					team_slots[i].card.colour = teamP1[i].colour
			2:
				if teamP2[i] == null and team_slots[i].card != null:
					team_slots[i].card.queue_free()
				elif teamP2[i] != null and teamP2[i].colour != team_slots[i].card.colour:
					team_slots[i].card.colour = teamP2[i].colour
			3:
				if teamP3[i] == null and team_slots[i].card != null:
					team_slots[i].card.queue_free()
				elif teamP3[i] != null and teamP3[i].colour != team_slots[i].card.colour:
					team_slots[i].card.colour = teamP3[i].colour
			4:
				if teamP4[i] == null and team_slots[i].card != null:
					team_slots[i].card.queue_free()
				elif teamP4[i] != null and teamP4[i].colour != team_slots[i].card.colour:
					team_slots[i].card.colour = teamP4[i].colour
	await update_friends()
	round += 1
	card_proc_order.clear()
	for friend in friends:
		if friend != null:
			card_proc_order.append(friend)
	card_proc_order.sort_custom(sort_hp)
	await get_tree().create_timer(1).timeout
	for card in card_proc_order:
		if card != null:
			if card.reduce_attack > 0:
				card.attack -= card.reduce_attack
				card.reduce_attack = 0
				card.setStatText()
			if card.reduceX > 0:
				card.x -= card.reduceX
				card.reduceX = 0
				card.setStatText()
			for i in range(card.swapATKandX):
				var tempATK = card.attack
				card.attack = card.x
				card.x = tempATK
			card.swapATKandX = 0
			card.setStatText()
			card.setColour()
			await card.start_turn()

func activate_cards_end_turn():
	update_friends()
	card_proc_order.clear()
	for friend in friends:
		if friend != null:
			card_proc_order.append(friend)
	card_proc_order.sort_custom(sort_hp)
	for card in card_proc_order:
		await card.end_turn()

func move_symbol(pos1, pos2, texture, text):
	move_symbols.append(this_symbol.duplicate())
	get_tree().get_first_node_in_group("main").add_child(move_symbols[move_symbols.size() - 1])
	move_symbols[move_symbols.size() - 1].set_path(pos1, pos2, texture, text)

func card_bought(card):
	update_friends()
	card_proc_order.clear()
	for friend in friends:
		if friend != null and friend != card:
			card_proc_order.append(friend)
	card_proc_order.sort_custom(sort_hp)
	for c in card_proc_order:
		if c is Card:
			await c.buy_card(card)

func card_sold(card):
	update_friends()
	card_proc_order.clear()
	for friend in friends:
		if friend != null and friend != card:
			card_proc_order.append(friend)
	card_proc_order.sort_custom(sort_hp)
	for c in card_proc_order:
		await c.sell_card(card.colour, card.cost)

func item_used(card):
	update_friends()
	card_proc_order.clear()
	for friend in friends:
		if friend != null and friend != card:
			card_proc_order.append(friend)
		if friend == card and friend != null:
			await card.use_item()
	card_proc_order.sort_custom(sort_hp)
	for c in card_proc_order:
		await c.friend_uses_item(card)

func friend_died_in_shop(dead_catagory):
	update_friends()
	card_proc_order.clear()
	for friend in friends:
		if friend != null:
			card_proc_order.append([friend, dead_catagory])
	card_proc_order.sort_custom(sort_hp_friend_died)
	for c in card_proc_order:
		await c[0].friend_dies(c[1])

func sort_hp_friend_died(a, b):
	if a[0].hp > b[0].hp:
		return true
	return false

func rerolled():
	update_friends()
	card_proc_order.clear()
	for friend in friends:
		if friend != null:
			card_proc_order.append(friend)
	card_proc_order.sort_custom(sort_hp)
	for c in card_proc_order:
		await c.reroll()


func set_player_teams(num, team):
	var new_team = []
	for data_set in team:
		new_team.append(construct_card(data_set))
	match num:
		1:
			teamP1 = new_team
		2:
			teamP2 = new_team
		3:
			teamP3 = new_team
		4:
			teamP4 = new_team

func set_player_stats(num, stats):
	match num:
		1:
			statsP1 = stats
		2:
			statsP2 = stats
		3:
			statsP3 = stats
		4:
			statsP4 = stats

func convert_card_to_data(card):
	var card_data = {
		"file_path" : "",
		"card_name" : "",
		"cost" : 0,
		"hp" : 0,
		"attack" : 0,
		"x" : 0,
		"target" : null,
		"colour" : null,
		"ability" : "",
		"upgraded_ability" : "",
		"n" : 0,
		"catagory" : null,
		"upgraded" : false,
		"reduce_x" : 0,
		"swap_attack_and_x" : 0,
		"blocked_ability" : false,
		"reduce_attack" : 0,
		"in_shop" : false,
		"in_battle" : true,
		"in_menu" : false,
		"leader" : false,
		"targets_order" : [],
		"team_number" : 0,
		"choices" : null,
		"options" : null,
		"attack_order" : null,
		"attack_order_possibilities" : null,
		"block_order" : null,
		"colour_order" : null,
		"this_colour" : null,
		"didnt_win_last_battle" : null,
		"target_teams" : null,
		"possible_target_teams" : null,
		"random_choices" : null,
		"target_order" : null,
		"this_target" : null,
		"choice" : null,
		"colour_order2" : null,
		"this_colour2" : null,
		"possible_index" : null
		}
	if card == null:
		card_data = null
	else:
		var file_path_name = card.card_name.to_snake_case()
		if card.card_name == "Matt Phillips":
			card_data["file_path"] = "res://scenes/matt_phillips.tscn"
		elif card.card_name == "Josh":
			card_data["file_path"] = "res://scenes/josh.tscn"
		elif card.card_name == "James":
			card_data["file_path"] = "res://scenes/james.tscn"
		elif card.card_name == "Harry":
			card_data["file_path"] = "res://scenes/harry.tscn"
		elif card.card_name == "MC Dect. Schmalade":
			card_data["file_path"] = "res://scenes/mc_dect_schmalade.tscn"
		elif card.card_name == "Dr. Haddock":
			card_data["file_path"] = "res://scenes/dr_haddock.tscn"
		elif card.card_name == "Dr. Schlotson":
			card_data["file_path"] = "res://scenes/dr_schlotson.tscn"
		elif card.card_name == "EU4":
			card_data["file_path"] = "res://scenes/eu_4.tscn"
		elif card.card_name == "Mr. Baybutt":
			card_data["file_path"] = "res://scenes/mr_baybutt.tscn"
		elif card.card_name == "Mr. Boothman":
			card_data["file_path"] = "res://scenes/mr_boothman.tscn"
		elif card.card_name == "Mr. Fairclough":
			card_data["file_path"] = "res://scenes/mr_fairclough.tscn"
		elif card.card_name == "Mr. Monopoly":
			card_data["file_path"] = "res://scenes/mr_monopoly.tscn"
		elif card.card_name == "Skribbl.io":
			card_data["file_path"] = "res://scenes/skribbl_io.tscn"
		elif card.card_name == "Tower Vets":
			card_data["file_path"] = "res://scenes/loki.tscn"
		else:
			card_data["file_path"] = "res://scenes/" + file_path_name + ".tscn"
		card_data["card_name"] = card.card_name
		card_data["cost"] = card.cost
		card_data["hp"] = card.hp
		card_data["attack"] = card.attack
		card_data["x"] = card.x
		card_data["target"] = card.target
		card_data["colour"] = card.colour
		card_data["ability"] = card.ability
		card_data["upgraded_ability"] = card.upgradedAbility
		card_data["n"] = card.n
		card_data["catagory"] = card.catagory
		card_data["upgraded"] = card.upgraded
		card_data["reduce_x"] = card.reduceX
		card_data["swap_attack_and_x"] = card.swapATKandX
		card_data["blocked_ability"] = card.blocked_ability
		card_data["reduce_attack"] = card.reduce_attack
		card_data["in_shop"] = false
		card_data["in_battle"] = true
		card_data["in_menu"] = false
		card_data["leader"] = card.leader
		card_data["targets_order"] = card.targets_order
		card_data["team_number"] = card.team_number
		card_data["choices"] = card.choices
		card_data["options"] = card.options
		card_data["attack_order"] = card.attack_order
		card_data["attack_order_possibilities"] = card.attack_order_possibilities
		card_data["block_order"] = card.block_order
		card_data["colour_order"] = card.colour_order
		card_data["this_colour"] = card.this_colour
		card_data["didnt_win_last_battle"] = card.didnt_win_last_battle
		card_data["target_teams"] = card.target_teams
		card_data["possible_target_teams"] = card.possible_target_teams
		card_data["random_choices"] = card.random_choices
		card_data["target_order"] = card.target_order
		card_data["this_target"] = card.this_target
		card_data["choice"] = card.choice
		card_data["colour_order2"] = card.colour_order2
		card_data["this_colour2"] = card.this_colour2
		card_data["possible_index"] = card.possible_index
	return card_data

func construct_card(card_data):
	var new_card
	if card_data == null:
		new_card = null
	else:
		new_card = load(card_data["file_path"]).instantiate()
		while new_card == null:
			pass
		new_card.card_name = card_data["card_name"]
		new_card.cost = card_data["cost"]
		new_card.hp = card_data["hp"]
		new_card.attack = card_data["attack"]
		new_card.x = card_data["x"]
		new_card.target = card_data["target"]
		new_card.colour = card_data["colour"]
		new_card.ability = card_data["ability"]
		new_card.upgradedAbility = card_data["upgraded_ability"]
		new_card.n = card_data["n"]
		new_card.catagory = card_data["catagory"]
		new_card.upgraded = card_data["upgraded"]
		new_card.reduceX = card_data["reduce_x"]
		new_card.swapATKandX = card_data["swap_attack_and_x"]
		new_card.blocked_ability = card_data["blocked_ability"]
		new_card.reduce_attack = card_data["reduce_attack"]
		new_card.inShop = card_data["in_shop"]
		new_card.inBattle = card_data["in_battle"]
		new_card.inMenu = card_data["in_menu"]
		new_card.leader = card_data["leader"]
		new_card.targets_order = card_data["targets_order"]
		new_card.team_number = card_data["team_number"]
		new_card.choices = card_data["choices"]
		new_card.options = card_data["options"]
		new_card.attack_order = card_data["attack_order"]
		new_card.attack_order_possibilities = card_data["attack_order_possibilities"]
		new_card.block_order = card_data["block_order"]
		new_card.colour_order = card_data["colour_order"]
		new_card.this_colour = card_data["this_colour"]
		new_card.didnt_win_last_battle = card_data["didnt_win_last_battle"]
		new_card.target_teams = card_data["target_teams"]
		new_card.possible_target_teams = card_data["possible_target_teams"]
		new_card.random_choices = card_data["random_choices"]
		new_card.target_order = card_data["target_order"]
		new_card.this_target = card_data["this_target"]
		new_card.choice = card_data["choice"]
		new_card.colour_order2 = card_data["colour_order2"]
		new_card.this_colour2 = card_data["this_colour2"]
		new_card.possible_index = card_data["possible_index"]
	return new_card

@rpc("any_peer", "call_local")
func add_to_ready_players(player_number):
	ready_players_tracker[player_number - 1] = true
	ready_players = ready_players_tracker.count(true)
	if ready_players == 4:
		ready_players_tracker = [false, false, false, false]
