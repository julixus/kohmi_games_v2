extends VideoStreamPlayer

var loop_video
var transition_done := false

func _ready() -> void:
	loop_video = load("res://res/Videos/loop_bg_real(2).ogv")

func _process(delta: float) -> void:
	if not is_playing() and not transition_done:
		stream = loop_video
		loop = true
		play()
		transition_done = true
