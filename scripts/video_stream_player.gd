extends VideoStreamPlayer

var loop_video
var transition_done := false

func _ready() -> void:
	print("ready")
	loop_video = load("res://res/Videos/loop_bg_real(2).ogv")

func _process(delta: float) -> void:
	if not is_playing() and not transition_done:
		print("finished")
		stream = loop_video
		loop = true
		play()
		transition_done = true
