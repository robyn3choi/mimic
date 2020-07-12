extends Area2D

signal got_coin

var is_waiting_for_particle_end = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_waiting_for_particle_end && !$Particles2D.emitting:
		queue_free()


func _on_Coin_body_entered(body: Node) -> void:
	if body.get_parent().name == "Player":
		Game.add_point()
		emit_signal('got_coin')
		$Sprite.hide()
		$Pulse.hide()
		$AnimationPlayer.stop()
		$Particles2D.emitting = true
		is_waiting_for_particle_end = true
