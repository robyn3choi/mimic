extends Node

var rng = RandomNumberGenerator.new()
var assist_scene = preload("res://Assist.tscn")
var edge_buffer = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()

func spawn_assist():
	var assist = assist_scene.instance()
	
	var screen_size = get_viewport().get_visible_rect().size
	var x = rng.randi_range(edge_buffer, screen_size.x-edge_buffer)
	var y = rng.randi_range(edge_buffer, screen_size.y-edge_buffer)
	assist.position = Vector2(x, y)
	
	assist.connect("got_assist", $'../Player', "assist")
	add_child(assist)



func _on_AssistSpawnTimer_timeout() -> void:
	spawn_assist()
