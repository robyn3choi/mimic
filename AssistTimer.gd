extends Timer

var num_assist_ticks = 8
var blink_duration = 0.5
var num_times_blinked = 0
var num_ticks_before_blinking = 3
var tick_counter = 0

func start_timer():
	num_times_blinked = 0
	tick_counter = 1
	$TickAudio.play()
	start()


func _on_AssistTimer_timeout() -> void:
	if tick_counter % 2 == 0:
		$TickAudio.play()
	else:
		$TockAudio.play()
		
	tick_counter += 1
		
	if tick_counter >= num_ticks_before_blinking:
		$'../Movement'.toggle_color()
		
	if (tick_counter >= num_assist_ticks):
		stop()
		$'../Movement'.be_default_color()
		return
	
	start()
	
	
