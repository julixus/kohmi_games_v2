extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var countdown_label: Label = $Countdown_label
@onready var timer: Timer = $Timer
@onready var hp_label: Label = $hp_label
@onready var check_button: Button = $CheckButton
@onready var info_btn: Button = $info_btn
@onready var help_ui: Control = $help_ui

var punkte : int = 0;
var can_click = true
var lives = 3
var index = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/Grafikfehler2.jpg")
	check_button.size = Vector2(90, 24)
	check_button.position = Vector2(94, -9)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Score: " + str(punkte)
	countdown_label.text = str(roundi(timer.time_left)) + "s"
	hp_label.text = str(lives) +"/3 HP"
	
	#if  index == 1:
		#sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/Grafikfehler2.jpg")
		#check_button.size = Vector2(90, 24)
		#check_button.position = Vector2(94, -9)
		
	if  index == 2:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/Grafikfehler3.jpg")
		check_button.size = Vector2(66, -24)
		check_button.position = Vector2(183, -69)
		
	if  index == 3:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/Grafikfehler1.jpg")
		check_button.size = Vector2(90, 24)
		check_button.position = Vector2(-49, -157)
		
	if  index == 4:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_01.png")
		check_button.size = Vector2(66, 24)
		check_button.position = Vector2(295, -99)
		
	if  index == 5:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_02.png")
		check_button.size = Vector2(123, 24)
		check_button.position = Vector2(141, 49)
		
	if  index == 6:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_03.png")
		check_button.size = Vector2(67, 24)
		check_button.position = Vector2(97, 196)
		
	if  index == 7:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_04.png")
		check_button.size = Vector2(99, 24)
		check_button.position = Vector2(-122, 197)
		
	if  index == 8:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_05.png")
		check_button.size = Vector2(76, 24)
		check_button.position = Vector2(-237, 108)
		
	if  index == 9:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_06.png")
		check_button.size = Vector2(57, 24)
		check_button.position = Vector2(193, 137)
		
	if  index == 10:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_07.png")
		check_button.size = Vector2(76, 24)
		check_button.position = Vector2(51, 79)
		
	if  index == 11:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_08.png")
		check_button.size = Vector2(126, 24)
		check_button.position = Vector2(14, 49)
		
	if  index == 12:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_09.png")
		check_button.size = Vector2(62, 24)
		check_button.position = Vector2(190, 196)
		
	if  index == 13:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_10.png")
		check_button.size = Vector2(75, 24)
		check_button.position = Vector2(-152, -39)
		
	if  index == 14:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_11.png")
		check_button.size = Vector2(101, 24)
		check_button.position = Vector2(27, -39)
		
	if  index == 15:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_12.png")
		check_button.size = Vector2(94, 24)
		check_button.position = Vector2(36, -128)
		
	if  index == 16:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_13.png")
		check_button.size = Vector2(116, 24)
		check_button.position = Vector2(151, 138)
		
	if  index == 17:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_14.png")
		check_button.size = Vector2(110, 24)
		check_button.position = Vector2(267, -39)
		
	if  index == 18:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_15.png")
		check_button.size = Vector2(84, 24)
		check_button.position = Vector2(263, -10)
		
	if  index == 19:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_16.png")
		check_button.size = Vector2(89, 24)
		check_button.position = Vector2(140, -40)
		
	if  index == 20:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_17.png")
		check_button.size = Vector2(78, 24)
		check_button.position = Vector2(277, 49)
		
	if  index == 21:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_18.png")
		check_button.size = Vector2(121, 24)
		check_button.position = Vector2(-97, 197)


#func _on_check_button_toggled(toggled_on: bool) -> void:
	#if can_click:
		#await show_solution()
		#punkte = punkte + 1
		#index += 1
		#lives = 3

func _on_timer_timeout() -> void:
	print("Zeit ist rum!")
	can_click = false
	Global.grafikfehler_score = punkte
	await wait(5)
	get_tree().change_scene_to_file("res://scenes/zwischenseq_2.tscn")

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.pressed):
		if lives > 1:
			lives -= 1
		else:
			await show_solution()
			index += 1
			lives = 3

func show_solution():
	print("show")
	var rect = ColorRect.new()
	rect.position = check_button.position
	rect.size = check_button.size
	rect.color = Color.GREEN
	rect.modulate = Color(0.0, 0.853, 0.0, 0.5)
	add_child(rect)
	await wait(1)
	rect.queue_free()


func _on_check_button_pressed() -> void:
	if can_click:
		await show_solution()
		punkte = punkte + 1
		index += 1
		lives = 3
		print(index)

func _on_info_btn_pressed() -> void:
	help_ui.visible = true
	timer.paused = true	

func _on_ok_button_pressed() -> void:
	print("ok button toggled")
	help_ui.visible = false
	timer.paused = false
