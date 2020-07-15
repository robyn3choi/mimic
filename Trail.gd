extends Line2D

var target
var point
var trail_length = 20
var is_enabled = true

func _physics_process(delta: float) -> void:
	if (is_enabled):
		point = $'../Movement'.get_position()
		add_point(point)
		while get_point_count() > trail_length:
			remove_point(0)
		

func disable():
	is_enabled = false
	points = []
	
func enable():
	is_enabled = true
	points = []
