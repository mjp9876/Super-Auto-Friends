extends Node2D

@onready var path = $Path2D
@onready var path_follow = $Path2D/PathFollow2D
@onready var symbol = $Path2D/PathFollow2D/symbol
@onready var label = $Path2D/PathFollow2D/symbol/Control/Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#set_path(Vector2(-700, 300), Vector2(700, -100), load("res://assets/card_icons/attack_icon.png"), "+1", Vector2(1, 1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if path_follow.progress_ratio >= 1:
		queue_free()
	elif symbol.visible:
		path_follow.progress_ratio = min(1, path_follow.progress_ratio + ((2 - path_follow.progress_ratio) * delta))
	if path_follow.progress_ratio > 0.85:
		symbol.modulate.a *= (1 - (3 * delta))
		symbol.scale *= (1 + (3 * delta))

func set_path(pos1, pos2, texture, text):
	path.curve.set_point_position(0, pos1)
	path.curve.set_point_position(1, Vector2(0.5 * (pos1.x + pos2.x), 0.5 * (pos1.y + pos2.y) - 800))
	path.curve.set_point_in(1, Vector2(0.4 * (pos1.x - pos2.x), 0))
	path.curve.set_point_out(1, Vector2(0.4 * (pos2.x - pos1.x), 0))
	path.curve.set_point_position(2, pos2)
	symbol.texture = texture
	symbol.visible = true
	label.text = text

