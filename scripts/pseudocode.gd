extends Node2D

@onready var header: Label = $UI/Header_Label
@onready var command: Label = $UI/Command_Label
@onready var timer: Timer = $Timer
@onready var goal_button: Button = $UI/Goal_Button
@onready var tile_area: Area2D = $Tile_Area


var time_score = 0
var time_label = "00:00"
var goal_pressed = false

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


func _on_goal_button_pressed() -> void:
	goal_pressed = true
	print("pressed")


func _on_tile_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.pressed):
			print ("incorrect")
