extends Node2D

@onready var header: Label = $UI/Header_Label
@onready var command: Label = $UI/Command_Label
@onready var timer: Timer = $Timer
@onready var goal_button: Button = $UI/Goal_Button
@onready var tile_area: Area2D = $Tile_Area
@onready var icon: Sprite2D = $Icon
@onready var score_label: Label = $UI/Score_Label
@onready var command_two: Label = $UI/Command_Label_Two
@onready var countdown: Timer = $countdown


var icon_pos_x = 279
var icon_pos_y = 157
var icon_rotation = 0
var icon_start = Vector2(180.5, 57)
var moving = false
const GRID_SIZE_X = 42.9
const GRID_SIZE_Y = 43.2
const OFFSET = Vector2(20.94,20.94)#Vector2(10,20)
var can_click = true
var direction : String
var time_score = 0
var time_label = "00:00"
var goal_pressed = false
var score = 0
var index = 0
var code = ["Start:\nmoveForward();\nturnLeft();\nmoveForward();", #1.1
			"Start:\nmoveForward();\nmoveForward();\nturnRight();\nturnRight();", #1.2
			"Start:\nturnLeft();\nmoveForward();\nmoveForward();\nturnRight();\nmoveForward();\nmoveForward();\nturnLeft();\nmoveForward();", #1.3
			"Start:\nturnLeft();\nturnLeft();\nturnLeft();\nmoveForward();\nmoveForward();\nturnRight();\nmoveForward();\nmoveForward();\nmoveForward();\nturnRight();\nmoveForward();\nmoveForward();\nturnRight();\nmoveForward();", #1.4
			"Start:\nfor(count:3){\nmoveForward();\n}", #2.1
			"Start:\nturnLeft();\nfor(count:2){\nmoveForward;\nturnLeft();\n}\nmoveForward();", #2.2
			"Start:\nfor(count:3){\nmoveForward();\n}\nturnLeft();\nfor(Count:5){\nmoveForward();\n}\nturnLeft();\nmoveForward();", #2.3
			"Start:\nfor(count:2){\nfor(count:2){\nmoveForward();\nturnRight();\n}\nturnRight();\nmoveForward();\nmoveForward();\nmoveForward();\n}", #2.4
			"Func doppelMove{\nmoveForward();\nmoveForward();\n}\n\nStart:\nturnLeft();\ndoppelMove();", #3.1
			"Func turnAround{\nturnLeft();\nturnLeft();\n}\n\nStart:\nmoveForward();\nmoveForward();\nturnLeft();\nturnAround();\nmoveForward();\nmoveForward();\nmoveForward();", #3.2
			"Func fourTurnOne{\nmoveForward();\nmoveForward();\nmoveForward();\nmoveForward();\nturnLeft();\nmoveForward();\n}\n\nStart:\nfourTurnOne();\nturnLeft();\nfourTurnOne();\nturnLeft();\nwalkForward();", #3.3
			"Func alpha{\nmoveForward();\nturnLeft();\nmoveForward();\nturnRight();\nmoveForward();\n}\n\nfunc beta{\nmoveForward();\nmoveForward();\nturnLeft();\nmoveForward();\n}\n\nStart:\nalpha();\nbeta();\nbeta();\nalpha()", #3.4
			"Func trippleWalk{\nfor(count:3){\nwalkForward();\n}\n}\n\nfunc zickZack{\nwalkForward();\nturnLeft();\nwalkForward();\nturnRight();\nwalkForward();\n}\n\nStart:\ntrippleWalk();\nturnRight();\nzickZack();\nturnRight();\ntrippleWalk();\ntrippleWalk();\nfor(count:1){\nzickZack();\n}\nturnRight();\nfor(count:2){\ntrippleWalk\n}\nturnRight();\nfor(Count:2){\nzickZack();", #4.1
			"func knightRight{\nmoveForward();\nmoveForward();\nturnRight();\nmoveForward();\nturnLeft();\n}\n\nfunc knightLeft{\nmoveForward();\nmoveForward();\nturnLeft();\nmoveForward();\nturnRight();\n}", #4.2
			"", #4.3
			""] #4.4

func _ready() -> void:
	var size : int = icon.scale.x
	direction = "Up"
	icon_pos_x = icon_start.x
	icon_pos_y = icon_start.y
	nextCode(0)
	moveButton(0)


func _process(delta: float) -> void:
	header.text = str(roundi(countdown.time_left)) + "s"
	score_label.text = str(score)
	
	icon.position = Vector2(icon_pos_x, icon_pos_y)
	icon.rotation_degrees = icon_rotation
	
	if index == 12:
		command_two.text = "\n\n\nStart:\ntrippleWalk();\nturnRight();\nzickZack();\nturnRight();\ntrippleWalk();\ntrippleWalk();\nfor(count:1){\nzickZack();\n}\nturnRight();\nfor(count:2){\ntrippleWalk\n}\nturnRight();\nfor(Count:2){\nzickZack();"
	elif index == 13:
		command_two.text = "\n\n\nfunc turnAround{\nfor(count:2){\nturnLeft();\n}\n}\n\nStart:\nturnAround();\nknightLeft();\nturnLeft();\nknightLeft();\nknightRight();\nturnAround();\nfor(count:4)\nknightRight();"
	else: command_two.text = ""
	
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
	var sb = StyleBoxFlat.new()
	sb.bg_color = Color(0, 70, 0, 0.5)
	if can_click:
		goal_pressed = true
		print("pressed")
		goal_button.add_theme_stylebox_override("normal", sb) #funktioniert nicht immer sofot, ka warum
		print("theme")
		await moveIcon(index)
		goal_button.remove_theme_stylebox_override("normal")
		if (score < len(code)):
			score = score + 1
			index += 1
		else:
			print("score ist maximal")
			#await wait(3)
			#get_tree().change_scene_to_file("res://scenes/grafikfehler.tscn")
		nextCode(index)
		moveButton(index)

func _on_tile_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.pressed && can_click):
		print ("incorrect")
		var mouse_pos = get_global_mouse_position()# + OFFSET #global weil gelegt von 0/0 bis +x/+x statt local mit -x/-x bis +x/+x
		print("mouse pos: "+str(mouse_pos))
		var grid_pos = snap_to_grid(mouse_pos)# - Vector2(167,167) #Alles scheiße Digga wtt
		grid_pos = grid_pos - Vector2(183,180)
		print("grid pos: "+ str(grid_pos))
		draw_rectangle_at(grid_pos)
		
		var rect = ColorRect.new()
		rect.color = Color(0, 70, 0, 0.5)
		rect.size = goal_button.size
		rect.position = goal_button.position
		add_child(rect)
		await moveIcon(index)
		rect.queue_free()
		index += 1
		nextCode(index)
		moveButton(index)
		
func snap_to_grid(pos: Vector2) -> Vector2:
	return Vector2(
		floor(pos.x / GRID_SIZE_X) * GRID_SIZE_X,
		floor(pos.y / GRID_SIZE_Y) * GRID_SIZE_Y
	)
	
func draw_rectangle_at(pos: Vector2) -> void:
	var rect = ColorRect.new()
	rect.color = Color(70,0,0,0.5)
	rect.size = Vector2(GRID_SIZE_X, GRID_SIZE_Y)
	rect.position = pos + Vector2(0.02, 0) #- OFFSET #blöder hs nimmt die position als local und nicht global position -> offset nicht überall gleich
	print("rect position: " + str(rect.position))
	add_child(rect)
	await wait(0.3)
	rect.queue_free()
			
func nextCode(index: int):
	if (index < len(code)):
		command.text = "Manuelle Sequenz:\n\n" + code[index]
	else:
		print("kein neuer Code vorhanden")
	
func moveButton(position: int):
	var buttonPositions = [Vector2(117, -7), Vector2(160,-49), Vector2(32, -49), Vector2(160, 123), Vector2(160, -92), Vector2(160,80), Vector2(-54, -49), Vector2(32, 80), Vector2(75, 37), Vector2(246, -49), Vector2(203, 37), Vector2(32, -7), Vector2(-54, 80), Vector2(32, -49), Vector2(0,0)]
	if (position < len(buttonPositions)):
		goal_button.position = buttonPositions[position]
	else:
		print("keine neuen buttonPositions mehr vorhanden")
	
func moveIcon(position: int):
	var delay = 0.5
	var delay_end = 1
	match position:
		0:
			can_click = false
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay_end)
			can_click = true
		1:
			can_click = false
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnRight()
			await wait(delay)
			turnRight()
			await wait(delay_end)
			can_click = true
		2:
			can_click = false
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
			can_click = true
		3:
			can_click = false
			turnLeft()
			await wait(delay)
			turnLeft()
			await wait(delay)
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
			moveForward()
			await wait(delay)
			turnRight()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnRight()
			await wait(delay)
			moveForward()
			await wait(delay_end)
			can_click = true
		4:
			can_click = false
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay_end)
			can_click = true
		5:
			can_click = false
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay_end)
			can_click = true
		6:
			can_click = false
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay_end)
			can_click = true
		7:
			can_click = false
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnRight()
			await wait(delay)
			turnRight()
			await wait(delay_end)
			can_click = true
		8:
			can_click = false
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay_end)
			can_click = true
		9:
			can_click = false
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			turnLeft()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay_end)
			can_click = true
		10:
			can_click = false
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay_end)
			can_click = true
		11:
			can_click = false
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnRight()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnLeft()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnRight()
			await wait(delay)
			moveForward()
			await wait(delay_end)
			can_click = true
		12:
			can_click = false
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnRight()
			await wait(delay)
			turnRight()
			await wait(delay_end)
			can_click = true
		13:
			can_click = false
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnRight()
			await wait(delay)
			turnRight()
			await wait(delay_end)
			can_click = true
		14:
			can_click = false
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnRight()
			await wait(delay)
			turnRight()
			await wait(delay_end)
			can_click = true
		15:
			can_click = false
			moveForward()
			await wait(delay)
			moveForward()
			await wait(delay)
			turnRight()
			await wait(delay)
			turnRight()
			await wait(delay_end)
			can_click = true
	direction = "Up"
	icon_rotation = 0
	icon_pos_x = icon_start.x
	icon_pos_y = icon_start.y

#Wartepause in Sekunden
func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

#Bewegt Spieler nach vorne
func moveForward():
	if direction == "Down":
		icon_pos_y = icon_pos_y + GRID_SIZE_Y
		print("1if down")
	if direction == "Up":
		icon_pos_y = icon_pos_y - GRID_SIZE_Y
		print("1if up")
	if direction == "Left":
		icon_pos_x = icon_pos_x - GRID_SIZE_X
		print("1if left")
	if direction == "Right":
		icon_pos_x = icon_pos_x + GRID_SIZE_X
		print("1if right")
		
#Dreht Spieler nach links
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
		
#Dreht Spieler nach rechts
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


func _on_countdown_timeout() -> void:
	print("Zeit ist rum")
	can_click = false
	await wait(3)
	get_tree().change_scene_to_file("res://scenes/grafikfehler.tscn")
