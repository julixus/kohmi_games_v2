extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var check_button: CheckButton = $CheckButton
@onready var label: Label = $Label

var punkte : int = 0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check_button.position = Vector2(100, 100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Punkte: " + str(punkte)
	if Input.is_action_just_pressed("TurnLeft") || punkte == 1:
		sprite_2d.texture = ResourceLoader.load("C:/Users/olche/Downloads/kohmi_games_v2/Picture/Test1.png")
		check_button.position = Vector2(100, 150)
	if Input.is_action_just_pressed("TurnRight") || punkte == 2:
		sprite_2d.texture = ResourceLoader.load("C:/Users/olche/Downloads/kohmi_games_v2/Picture/Test2.png")
		check_button.position = Vector2(200, 100)
	if Input.is_action_just_pressed("Move") || punkte == 3:
		sprite_2d.texture = ResourceLoader.load("C:/Users/olche/Downloads/kohmi_games_v2/Picture/Test3.png")
		check_button.position = Vector2(100, 100)


func _on_check_button_toggled(toggled_on: bool) -> void:
	punkte = punkte + 1
