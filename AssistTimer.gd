extends Timer

var assist_duration = 4
var blink_duration = 0.5
var num_assist_blinks = 4
var num_times_blinked = 0

func start_timer():
	print("assist timer start")
	num_times_blinked = 0
	wait_time = assist_duration
	start()


func _on_AssistTimer_timeout() -> void:
	if num_times_blinked == 0:
		wait_time = blink_duration
		start()
	elif num_times_blinked < num_assist_blinks:
		start()
		
	num_times_blinked += 1
