extends Node2D

@export var arena: PackedScene
@onready var main = $".."

@onready var wins = $GUI/wins
@onready var money = $GUI/money
@onready var rerollCost = $GUI/rerollCost

@onready var friend_shop_slots = [$shopSlot1, $shopSlot2, $shopSlot3, $shopSlot4, $shopSlot5]
@onready var item_shop_slots = [$itemSlot1, $itemSlot2]
@onready var upgrade_pop_up = $upgradePopUp
@onready var upgrade_pop_up_card_1_pos = $upgradePopUp/card1pos
@onready var upgrade_pop_up_card_2_pos = $upgradePopUp/card2pos
@onready var team_slots = [$leaderSlot, $friendSlot1, $friendSlot2, $friendSlot3, $friendSlot4, $friendSlot5]

@onready var money_img = $money_icon

@onready var team_colour_hand_label = $GUI/team_colour_hand

@onready var ready_button = $GUI/ready

var coin_icon = preload("res://assets/card_icons/cost_icon.png")

var reroll_cost = 0

var potential_card_to_upgrade
var c1
var c2

var colour_counts = [0, 0, 0, 0]
var hand_bonus
var colour_hand_values = {
	"Single": 7,
	"One Pair": 8,
	"Two Pair": 9,
	"One Trio": 9,
	"Everything": 10,
	"Three Pair": 12,
	"Full House": 12,
	"Four of a Kind": 12,
	"Two Trio": 13,
	"Fuller House": 13,
	"Five of a Kind": 13,
	"Six of a Kind": 15
}

# Called when the node enters the scene tree for the first time.
func _ready():
	updateText()

func updateText():
	wins.text = str(Manager.wins)
	money.text = str(Manager.money)
	rerollCost.text = str(reroll_cost)

func upgradeScene(card_to_upgrade):
	upgrade_pop_up.visible = true
	c1 = card_to_upgrade.duplicate()
	upgrade_pop_up.add_child(c1)
	c1.global_position = upgrade_pop_up_card_1_pos.global_position
	c1.scale.x = 0.3
	c1.scale.y = 0.3
	c2 = card_to_upgrade.duplicate()
	upgrade_pop_up.add_child(c2)
	c2.scale.x = 0.3
	c2.scale.y = 0.3
	c2.global_position = upgrade_pop_up_card_2_pos.global_position
	c2.upgraded = true
	c2.setStatText()
	c2.setAbilityText()
	potential_card_to_upgrade = card_to_upgrade

func _on_reroll_pressed():
	if reroll_cost <= Manager.money:
		Manager.money -= reroll_cost
		reroll_cost += 1
		updateText()
		for slot in friend_shop_slots:
			if slot.card != null:
				if not slot.card.locked:
					slot.card.queue_free()
		for slot in item_shop_slots:
			if slot.card != null:
				if not slot.card.locked:
					slot.card.queue_free()
		Manager.rerolled()

func _on_cancel_pressed():
	upgrade_pop_up.visible = false

func _on_confirm_pressed():
	upgrade_pop_up.visible = false
	potential_card_to_upgrade.upgraded = true
	Manager.money -= potential_card_to_upgrade.cost
	updateText()
	potential_card_to_upgrade.setStatText()
	potential_card_to_upgrade.setAbilityText()

func _on_ready_pressed():
	ready_button.disabled = true
	await Manager.activate_cards_end_turn()
	Manager.update_friends()
	colour_counts = [0, 0, 0, 0]
	for friend in Manager.friends:
		if friend != null:
			colour_counts[friend.colour] += 1
			Manager.move_symbol(friend.global_position, Vector2.ZERO, friend.find_colour_icon(friend.colour), "")
	if 6 in colour_counts:
		hand_bonus = "Six of a Kind"
	elif 5 in colour_counts:
		hand_bonus = "Five of a Kind"
	elif 4 in colour_counts and 2 in colour_counts:
		hand_bonus = "Fuller House"
	elif colour_counts.count(3) == 2:
		hand_bonus = "Two Trio"
	elif 4 in colour_counts:
		hand_bonus = "Four of a Kind"
	elif 3 in colour_counts and 2 in colour_counts:
		hand_bonus = "Full House"
	elif colour_counts.count(2) == 3:
		hand_bonus = "Three Pair"
	elif 0 not in colour_counts:
		hand_bonus = "Everything"
	elif 3 in colour_counts:
		hand_bonus = "One Trio"
	elif colour_counts.count(2) == 2:
		hand_bonus = "Two Pair"
	elif 2 in colour_counts:
		hand_bonus = "One Pair"
	else:
		hand_bonus = "Single"
	await get_tree().create_timer(0.8).timeout
	team_colour_hand_label.text = hand_bonus
	team_colour_hand_label.visible = true
	Manager.money += colour_hand_values[hand_bonus]
	Manager.move_symbol(Vector2.ZERO, money_img.global_position, coin_icon, str(colour_hand_values[hand_bonus]))
	updateText()
	await get_tree().create_timer(3).timeout
	team_colour_hand_label.visible = false
	Manager.friends = [null, null, null, null, null, null]
	start_battle()

func start_battle():
	for slot in team_slots:
		if slot.card != null:
			await slot.card.gather_fighting_info()
	Manager.gather_fighting_info_management_style()
	Manager.add_to_ready_players.rpc(Manager.playerNum)
	visible = false
	var areana = arena.instantiate()
	main.add_child(areana)

func free_reroll():
	for slot in friend_shop_slots:
		if slot.card != null:
			if not slot.card.locked:
				slot.card.queue_free()
	for slot in item_shop_slots:
		if slot.card != null:
			if not slot.card.locked:
				slot.card.queue_free()

func start_turn():
	reroll_cost = 1
	free_reroll()
	ready_button.disabled = false
	if Manager.round == 2:
		friend_shop_slots[3].active = true
		friend_shop_slots[3].visible = true
		item_shop_slots[1].active = true
		item_shop_slots[1].visible = true
	if Manager.round == 4:
		item_shop_slots[0].active = true
		item_shop_slots[0].visible = true
	if Manager.round == 6:
		friend_shop_slots[4].active = true
		friend_shop_slots[4].visible = true
	Manager.activate_cards_start_turn()
	updateText()
