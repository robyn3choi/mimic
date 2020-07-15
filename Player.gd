extends Node

signal player_died

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Movement.enable()


func _physics_process(delta):
	$Movement.go_straight()
	
	if Input.is_action_pressed("ui_left"):
		$Movement.go_left()
	elif Input.is_action_pressed("ui_right"):
		$Movement.go_right()
		

func get_position():
	return $Movement.position
	
	
func set_position(pos):
	$Movement.position = pos
	
	
func set_rotation(rot):
	$Movement.rotation_degrees = rot


func lose(body: Node) -> void:
	if body.get_parent() == self:
		emit_signal('player_died')
		stop()
		
		
func assist():
	$Movement.be_assist_color()
	$AssistTimer.start_timer()
	
func stop():
	$Movement.stop()
	$BlinkTimer.start()
