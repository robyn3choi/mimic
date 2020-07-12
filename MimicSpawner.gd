extends Node

var mimic_scene = preload("res://Mimic.tscn")
var rng = RandomNumberGenerator.new()


func _ready() -> void:
	rng.randomize()
	for i in 30:
		var mimic = mimic_scene.instance()
		mimic.disable(false)
		mimic.set_position(Vector2(-1000,-1000))
		$UnactiveMimics.add_child(mimic)
		$'../Boundaries'.connect("body_entered", mimic, 'die')
	

func spawn_mimics():
	var spawn_pos = $'../Player'.get_position()
	var random_angle = rng.randi_range(0, 359)
	var player_index = rng.randi_range(0, Game.score)
	var num_entities = Game.score + 1
	
	for i in range(num_entities):
		var rot = i * 360 / num_entities + random_angle
		if i == player_index:
			$'../Player'.set_rotation(rot)
		else:
			spawn_mimic(spawn_pos, rot)

			
func spawn_mimic(pos, rot):
	var mimic
	if $UnactiveMimics.get_child_count() > 0:
		mimic = $UnactiveMimics.get_child(0)
		$UnactiveMimics.remove_child(mimic)
	else:
		print("new mimic")
		mimic = mimic_scene.instance()
			
	mimic.set_position(pos)
	mimic.set_rotation(rot)
	$ActiveMimics.call_deferred('add_child', mimic)
	mimic.enable(true)
	
func recycle(mimic):
	print(mimic)
	mimic.set_position(Vector2(-1000,-1000))
	$ActiveMimics.call_deferred('remove_child', mimic)
	$UnactiveMimics.call_deferred('add_child', mimic)


func _on_Player_player_died() -> void:
	for m in $ActiveMimics.get_children():
		m.stop()
