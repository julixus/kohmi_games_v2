extends Node2D

@onready var label: RichTextLabel = $VBoxContainer/Label
@onready var sprecher: Label = $VBoxContainer/Sprecher
@onready var color_rect: ColorRect = $ColorRect
@onready var area_2d: Area2D = $Area2D
@onready var pseudocode_kohmi: Sprite2D = $PseudocodeKohmi
@onready var vsp: VideoStreamPlayer = $VideoStreamPlayer

var can_click = true
const SPEED = 1
var line_counter = 0
			#0
var lines = ["2 von 3 schon geschafft, herzlichen Glückwunsch!",
			"Ich wusste, du kannst mir helfen!",
			"Ich konnte dir diesmal sogar etwas zuschauen, das war schon teilweise echt hart!",
			"Wir haben nur noch eine Aufgabe vor uns, und die wird nach meinen Berechnungen ein ganz klassisches multiple Choice Quiz.",
			"Ich kann dir mal ein paar Antworten geben, falls du gleich auf dem Schlauch stehst.",
			"Bereit? Dann hör gut zu...",
			"...A",
			"...C",
			"...C",
			"...B",
			"...A",
			"... oder so irgendwie. Glaube ich. Allerdings kenne ich die Reihenfolge nicht. Naja.",
			"Du machst das schon!",
			"Übrigens: Ich habe inzwischen genug Kontrolle, um den Virus beliebig lange angreifbar zu machen, du hast also beim Quiz keinen Zeitdruck",
			"Und jetzt los in den Endspurt!",
			"", #ist wichtig, sonst wird zu schwarz gefadet bei letzer Zeile
			]

func _physics_process(delta: float) -> void:
	if line_counter == 0:
		await wait(1)
	label.visible_characters += SPEED
	
	if !vsp.is_playing():
		vsp.stream = load("res://res/Animations/Cycles-Kohmi-idle.ogv")
		vsp.loop = true
		vsp.play()

func _ready() -> void:
	label.visible_characters = 0
	print(lines[line_counter])
	sprecher.text = "Kohmi"
	label.text = ""	
	
	await wait(1)
	label.text = lines[line_counter]

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and can_click:
		next_line()
		if line_counter == 1:
			vsp.stream = load("res://res/Animations/Cycles-kohmi-freuen.ogv")
			vsp.loop = false
			vsp.play()
		if line_counter == 5:
			vsp.stream = load("res://res/Animations/Cycles-Kohmi-thinking.ogv")
			vsp.loop = false
			vsp.play()
		if line_counter == 12:
			vsp.stream = load("res://res/Animations/Cycles-kohmi-approval.ogv")
			vsp.loop = false
			vsp.play()
		if line_counter == len(lines)-1:
			can_click = false
			await fade_to_black()
			get_tree().change_scene_to_file("res://scenes/quiz.tscn")
	
func next_line():
	line_counter += 1
	label.text = lines[line_counter]
	label.visible_characters = 0	
	
func fade_to_black():
	var fadeTween = get_tree().create_tween()
	fadeTween.tween_property(color_rect, "modulate:a", 1.0, 2.0)
	await fadeTween.finished

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
