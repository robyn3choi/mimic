extends Area2D

signal got_assist

var is_waiting_for_particle_end = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_waiting_for_particle_end && !$Particles2D.emitting:
		queue_free()

func _on_Assist_body_entered(body) -> void:
	if body.get_parent().name == "Player":
		emit_signal('got_assist')
		$Sprite.hide()
		$Pulse.hide()
		$AnimationPlayer.stop()
		$Particles2D.emitting = true
		is_waiting_for_particle_end = true
