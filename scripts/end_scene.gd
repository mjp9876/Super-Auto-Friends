extends Node2D


var leader_card_data1
var leader_card_data2
var leader_card_data3
var leader_card_data4
var win_counts = []
var cards = [null, null, null, null]

@onready var trophies = [$wins1, $wins2, $wins3, $wins4]
@onready var wins_text = [$win_num1, $win_num2, $win_num3, $win_num4]

func construct_scene():
	for i in range(cards.size()):
		match i:
			0:
				cards[i] = Manager.construct_card(leader_card_data1)
			1:
				cards[i] = Manager.construct_card(leader_card_data2)
			2:
				cards[i] = Manager.construct_card(leader_card_data3)
			3:
				cards[i] = Manager.construct_card(leader_card_data4)
		add_child(cards[i])
		cards[i].global_position = trophies[i].global_position
		cards[i].global_position.y -= 1000
		cards[i].grow_size = 0.4
		cards[i].shrink_size = 0.28
		cards[i].scale *= 0.28
		if win_counts[i] == Manager.victory_wins:
			cards[i].global_position.y -= 300
			cards[i].scale *= 1.2
			cards[i].grow_size *= 1.2
			cards[i].shrink_size *= 1.2
		wins_text[i].text = str(win_counts[i])
