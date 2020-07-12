extends Node

var rng = RandomNumberGenerator.new()
var coin_scene = preload("res://Coin.tscn")
var edge_buffer = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()

func spawn_coin():
	var coin = coin_scene.instance()
	
	var screen_size = get_viewport().get_visible_rect().size
	var x = rng.randi_range(edge_buffer, screen_size.x-edge_buffer)
	var y = rng.randi_range(edge_buffer, screen_size.y-edge_buffer)
	coin.position = Vector2(x, y)
	
	coin.connect("got_coin", $'../MimicSpawner', "spawn_mimics")
	coin.connect("got_coin", $'../ScoreLabel', "update_score")
	add_child(coin)


func _on_CoinSpawnTimer_timeout() -> void:
	spawn_coin()
