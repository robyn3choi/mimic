extends Node

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	change_movement()


func _on_Timer_timeout() -> void:
	change_movement()


func change_movement():
	var rand = rng.randi_range(0, 2)
	if rand == 0:
		$Movement.go_straight()
	elif rand == 1:
		$Movement.go_left()
	else:
		$Movement.go_right()
	
	$Timer.wait_time = rng.randf_range(0.1, 4.0)
	$Timer.start()
	

func set_position(pos):
	$Movement.position = pos
	
	
func set_rotation(rot):
	$Movement.rotation_degrees = rot
	
func die(body: Node):
	if !$Movement/CollisionShape2D.disabled && body.get_parent() == self:
		disable(true)
		get_parent().get_parent().recycle(self)
		
func disable(deferred):
	$Movement.disable(deferred)
	$Trail.disable()
	
func enable(deferred):
	$Movement.enable(deferred)
	$Trail.enable()
	
func stop():
	$Movement.stop()
