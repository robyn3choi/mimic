extends Label

var seconds = 0
var minutes = 2
var red = '#ff2626'

func start():
	set_text(str(minutes, ":", str(seconds).pad_zeros(2)))
	$GameTimer.start()


func _on_GameTimer_timeout() -> void:
	seconds -= 1
	
	if seconds == -1:
		seconds = 59
		minutes -= 1
	if minutes == 0 && seconds == 0:
		$GameTimer.stop()
		get_parent().lose()
		
	set_text(str(minutes, ":", str(seconds).pad_zeros(2)))
	
	if minutes == 0 && seconds <= 5:
		set("custom_colors/font_color", Color('#ff2626'))
		$RedAudio.play()
