extends Node2D
@onready var timer: Timer = $Timer
@onready var icon: Sprite2D = $Icon

var direction : String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var size : int = icon.scale.x
	direction = "Up"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Move"):
		if direction == "Down":
			icon.position = icon.position + Vector2(0, 29.75)
		if direction == "Up":
			icon.position = icon.position - Vector2(0, 29.75)
		if direction == "Left":
			icon.position = icon.position - Vector2(29.75, 0)
		if direction == "Right":
			icon.position = icon.position + Vector2(29.75, 0)
	
	if Input.is_action_just_pressed("TurnLeft"):
			icon.rotation_degrees = icon.rotation_degrees - 90
			if direction == "Up":
				direction = "Left"
			elif direction == "Left":
				direction = "Down"
			elif direction == "Down":
				direction = "Right"
			elif direction == "Right":
				direction = "Up"
	
	if Input.is_action_just_pressed("TurnRight"):
			icon.rotation_degrees = icon.rotation_degrees + 90
			if direction == "Up":
				direction = "Right"
			elif direction == "Right":
				direction = "Down"
			elif direction == "Down":
				direction = "Left"
			elif direction == "Left":
				direction = "Up"
