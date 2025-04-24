extends Card

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	this_x = 0
	next_target = 0
	start_pos = global_position
	for i in range(1000):
		targets_order.append(0)
