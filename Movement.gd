extends KinematicBody2D

var velocity
var rotate_speed = 300
var is_left = false
var is_right = false
var is_stopped = false
var assist_color = '#ff7c00'
onready var default_color = $ColorRect.color
var is_assist_color = false

func _physics_process(delta):
	if !$CollisionShape2D.disabled && !is_stopped:
		var velocity = Vector2(Game.speed, 0)
		if is_left:
			rotation_degrees -= rotate_speed * delta
		elif is_right:
			rotation_degrees += rotate_speed * delta
			
		move_and_collide(velocity.rotated(deg2rad(rotation_degrees)))


func go_straight():
	is_left = false
	is_right = false
	
func go_left():
	is_left = true
	is_right = false
	
func go_right():
	is_left = false
	is_right = true
	

func disable(deferred = false):
	$ColorRect.hide()
	if deferred:
		$CollisionShape2D.set_deferred('disabled', true)
	else:
		$CollisionShape2D.disabled = true
	
func enable(deferred = false):
	$ColorRect.show()
	if deferred:
		$CollisionShape2D.set_deferred('disabled', false)
	else:
		$CollisionShape2D.disabled = false
		
func stop():
	is_stopped = true


func _on_BlinkTimer_timeout() -> void:
	if visible:
		hide()
	else:
		show()


func _on_AssistTimer_timeout() -> void:
	toggle_color()
	
	
func toggle_color():
	if is_assist_color:
		$ColorRect.color = default_color
	else:
		$ColorRect.color = assist_color
	
	is_assist_color = !is_assist_color
