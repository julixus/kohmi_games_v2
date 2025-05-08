extends Node2D

@onready var header: Label = $UI/Header_Label
@onready var command: Label = $UI/Command_Label
@onready var timer: Timer = $Timer
var time_score = 0
var time_label = "00:00"

func _process(delta: float) -> void:
	header.text = "Kohmi Connection Protokoll

Connection Status: Good

Time: "+time_label+"

Score: 0"

func _on_timer_timeout() -> void:
	time_score += 1
	var m = int(time_score/60)
	var s = time_score - m * 60
	time_label = '%02d:%02d' % [m, s]
