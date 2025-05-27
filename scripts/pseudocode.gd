extends Node2D

@onready var header: Label = $UI/Header_Label
@onready var command: Label = $UI/Command_Label
@onready var timer: Timer = $Timer
@onready var goal_button: Button = $UI/Goal_Button
@onready var tile_area: Area2D = $Tile_Area
@onready var icon: Sprite2D = $Icon

var icon_pos_x = 279
var icon_pos_y = 157
var icon_rotation = 0
var icon_start = Vector2(279, 157)
const GRID_SIZE = 30
const OFFSET = Vector2(6,9)

var direction : String
var time_score = 0
var time_label = "00:00"
var goal_pressed = false
var score = 0
var code = ["MoveForward();\nturnLeft();\nmoveForward();", "MoveForward();\nmoveForward();\nturnRight();\nturnRight();",
			"TurnLeft();\nMoveForward();\nMoveForward();\nTurnRight();\nMoveForward();\nMoveForward();\nTurnLeft();\nMoveForward();"]

func _ready() -> void:
	var size : int = icon.scale.x
	direction = "Up"
	nextCode(0)
	moveButton(0)


func _process(delta: float) -> void:
	header.text = "Kohmi Connection Protokoll\n\nConnection Status: Good\n\nTime: "+time_label+"\n\nScore: "+str(score)
	icon.position = Vector2(icon_pos_x, icon_pos_y)
	icon.rotation_degrees = icon_rotation
	
	#TODO: kommt noch raus vor release
	if Input.is_action_just_pressed("Move"):
		moveForward()
	if Input.is_action_just_pressed("TurnLeft"):
			turnLeft()
	if Input.is_action_just_pressed("TurnRight"):
			turnRight()
	
func _on_timer_timeout() -> void:
	time_score += 1
	var m = int(time_score/60)
	var s = time_score - m * 60
	time_label = '%02d:%02d' % [m, s]


func _on_goal_button_pressed() -> void:
	goal_pressed = true
	print("pressed")
	moveIcon(score)
	if (score < len(code)):
		score = score + 1
	else:
		print("score ist maximal")
	nextCode(score)
	moveButton(score)

func _on_tile_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.pressed):
		print ("incorrect")
		var mouse_pos = get_local_mouse_position() - OFFSET
		var grid_pos = snap_to_grid(mouse_pos)
		draw_rectangle_at(grid_pos)
		
func snap_to_grid(pos: Vector2) -> Vector2:
	return Vector2(
		floor(pos.x / GRID_SIZE) * GRID_SIZE,
		floor(pos.y / GRID_SIZE) * GRID_SIZE
	)
	
func draw_rectangle_at(pos: Vector2) -> void:
	var rect = ColorRect.new()
	rect.color = Color.BLUE
	rect.size = Vector2(GRID_SIZE, GRID_SIZE)
	rect.position = pos - OFFSET
	rect.modulate = Color(1,1,1,0.5)
	add_child(rect)
	await wait(0.3)
	rect.queue_free()
			
func nextCode(index: int):
	if (index < len(code)):
		command.text = "Manuelle Sequenz:\n\n" + code[index]
	else:
		print("kein neuer Code vorhanden")
	
func moveButton(position: int):
	var buttonPositions = [Vector2(235, 113), Vector2(263, 83), Vector2(174, 83)]
	if (position < len(buttonPositions)):
		goal_button.position = buttonPositions[position]
	else:
		print("keine neuen buttonPositions mehr vorhanden")
	
func moveIcon(position: int):
	var delay = 0.5
	var delay_end = 1
	match position:
		0:
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay_end)
		1:
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnRight()
			await wait(delay)
			turnRight()
			await wait(delay_end)
		2:
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnRight()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay_end)
	direction = "Up"
	icon_rotation = 0
	icon_pos_x = icon_start.x
	icon_pos_y = icon_start.y

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

func moveForward():
	if direction == "Down":
		icon_pos_y = icon_pos_y + 29.75
		print("1if down")
	if direction == "Up":
		icon_pos_y = icon_pos_y - 29.75
		print("1if up")
	if direction == "Left":
		icon_pos_x = icon_pos_x - 29.75
		print("1if left")
	if direction == "Right":
		icon_pos_x = icon_pos_x + 29.75
		print("1if right")
		
func turnLeft():
	icon_rotation = icon_rotation - 90
	if direction == "Up":
		print("2if up")
		direction = "Left"
	elif direction == "Left":
		print("2if left")
		direction = "Down"
	elif direction == "Down":
		print("2if down")
		direction = "Right"
	elif direction == "Right":
		print("2if right")
		direction = "Up"
		
func turnRight():
	icon_rotation = icon_rotation + 90
	if direction == "Up":
		direction = "Right"
	elif direction == "Right":
		direction = "Down"
	elif direction == "Down":
		direction = "Left"
	elif direction == "Left":
		direction = "Up"
