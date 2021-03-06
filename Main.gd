extends Node

var player_start_pos = Vector2(180, 360)
var player_scene = preload("res://Player.tscn")

func start_game():
	var player = player_scene.instance()
	player.set_position(player_start_pos)
	player.connect('player_died', self, 'lose')
	$MimicSpawner/ActiveMimics.add_child(player)
	Game.player = player
	
	$IntroUI.hide()
	$CoinSpawner/CoinSpawnTimer.start()
	$AssistSpawner/AssistSpawnTimer.start()
	$ScoreLabel.show()
	$GameTimerLabel.start()
	$CoinSpawner.spawn_coin()
	$Boundaries.connect('body_entered', player, 'lose')


func _on_PlayButton_pressed() -> void:
	start_game()


func lose():
	$LoseAudio.play()
	$CoinSpawner/CoinSpawnTimer.stop()
	$MimicSpawner.stop()
	Game.player.stop()
	if Game.score == 1:
		$LoseUI/Text.text = "Darn, you only got 1 point!"
	else:
		$LoseUI/Text.text = "Cool, you got " + String(Game.score) + " points!"
	$LoseUI.show()


func _on_PlayAgainButton_pressed() -> void:
	Game.score = 0
	get_tree().reload_current_scene()
