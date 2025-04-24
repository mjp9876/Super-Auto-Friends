extends Node2D

@onready var symbol = $symbol
@onready var label = $symbol/Control/Label
@onready var die_time = $die

var moving = false
var startPos
var endPos = Vector2.ZERO
var imgUp = true
var symbol_target_height
var kill = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if moving:
		global_position = lerp(global_position, endPos, 3 * delta)
		if imgUp:
			if symbol.position.y <= -600 and symbol.global_position.y <= (endPos.y - 200):
				imgUp = false
			symbol.position = lerp(symbol.position, Vector2(0, -700), 6 * delta)
		else:
			if global_position.distance_to(endPos) < 200:
				symbol.modulate.a *= (1 - (10 * delta))
				symbol.scale *= (1 + (3 * delta))
			symbol.position = lerp(symbol.position, Vector2(0, 0), 6 * delta)
			if global_position.distance_to(endPos) < 75 and kill:
				kill = false
				die_time.start()


func set_path(pos1, pos2, texture, text):
	startPos = pos1
	endPos.x = pos2.x * 1.02
	endPos.y = pos2.y * 1.02
	symbol.texture = texture
	symbol.visible = true
	label.text = text
	global_position = startPos
	moving = true


func _on_die_timeout():
	queue_free()
