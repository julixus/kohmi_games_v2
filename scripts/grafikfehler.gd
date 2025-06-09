extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var check_button: CheckButton = $CheckButton
@onready var label: Label = $Label

var punkte : int = 0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/Grafikfehler2.jpg")
	check_button.size = Vector2(90, 24)
	check_button.position = Vector2(94, -9)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(punkte)
		
	if  punkte == 1:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/Grafikfehler2.jpg")
		check_button.size = Vector2(90, 24)
		check_button.position = Vector2(94, -9)
		
	if  punkte == 2:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/Grafikfehler3.jpg")
		check_button.size = Vector2(66, -24)
		check_button.position = Vector2(183, -69)
		
	if  punkte == 3:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/Grafikfehler1.jpg")
		check_button.size = Vector2(90, 24)
		check_button.position = Vector2(-49, -157)
		
	if  punkte == 4:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_01.png")
		check_button.size = Vector2(66, 24)
		check_button.position = Vector2(295, -99)
		
	if  punkte == 5:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_02.png")
		check_button.size = Vector2(123, 24)
		check_button.position = Vector2(141, 49)
		
	if  punkte == 6:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_03.png")
		check_button.size = Vector2(67, 24)
		check_button.position = Vector2(97, 196)
		
	if  punkte == 7:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_04.png")
		check_button.size = Vector2(99, 24)
		check_button.position = Vector2(-122, 197)
		
	if  punkte == 8:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_05.png")
		check_button.size = Vector2(76, 24)
		check_button.position = Vector2(-237, 108)
		
	if  punkte == 9:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_06.png")
		check_button.size = Vector2(57, 24)
		check_button.position = Vector2(193, 137)
		
	if  punkte == 10:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_07.png")
		check_button.size = Vector2(76, 24)
		check_button.position = Vector2(51, 79)
		
	if  punkte == 11:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_08.png")
		check_button.size = Vector2(126, 24)
		check_button.position = Vector2(14, 49)
		
	if  punkte == 12:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_09.png")
		check_button.size = Vector2(62, 24)
		check_button.position = Vector2(190, 196)
		
	if  punkte == 13:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_10.png")
		check_button.size = Vector2(75, 24)
		check_button.position = Vector2(-152, -39)
		
	if  punkte == 14:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_11.png")
		check_button.size = Vector2(101, 24)
		check_button.position = Vector2(27, -39)
		
	if  punkte == 15:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_12.png")
		check_button.size = Vector2(94, 24)
		check_button.position = Vector2(36, -128)
		
	if  punkte == 16:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_13.png")
		check_button.size = Vector2(116, 24)
		check_button.position = Vector2(151, 138)
		
	if  punkte == 17:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_14.png")
		check_button.size = Vector2(110, 24)
		check_button.position = Vector2(267, -39)
		
	if  punkte == 18:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_15.png")
		check_button.size = Vector2(84, 24)
		check_button.position = Vector2(263, -10)
		
	if  punkte == 19:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_16.png")
		check_button.size = Vector2(89, 24)
		check_button.position = Vector2(140, -40)
		
	if  punkte == 20:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_17.png")
		check_button.size = Vector2(78, 24)
		check_button.position = Vector2(277, 49)
		
	if  punkte == 21:
		sprite_2d.texture = ResourceLoader.load("res://res/Grafikfehler_images/GrFe_18.png")
		check_button.size = Vector2(121, 24)
		check_button.position = Vector2(-97, 197)


func _on_check_button_toggled(toggled_on: bool) -> void:
	punkte = punkte + 1
