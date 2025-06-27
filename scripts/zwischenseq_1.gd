extends Node2D

@onready var label: RichTextLabel = $VBoxContainer/Label
@onready var sprecher: Label = $VBoxContainer/Sprecher
@onready var color_rect: ColorRect = $ColorRect
@onready var area_2d: Area2D = $Area2D
@onready var pseudocode_kohmi: Sprite2D = $PseudocodeKohmi
@onready var plakat_kohmi: Sprite2D = $PlakatKohmiGroeHand4kFinal
@onready var video_stream_player: VideoStreamPlayer = $VideoStreamPlayer

var can_click = true
const SPEED = 1
var line_counter = 0
			#0
var lines = ["Wilkommen zurück, das hast du ja gut gemeistert!",
			"Dank dir habe ich jetzt wieder genug Kontrolle zurückerlangt, dass ich mir dir auch zeigen kann...",
			"Hier bin ich!",
			"Ich hoffe, ich hab dich nicht erschreckt.",
			"...",
			"Du hast auf jeden Fall gute Arbeit geleistet. Ich kann spüren, wie der Virus schwächer wird.",
			"Die nächste Aufgabe dreht sich, nach dem was ich sehen kann, um designerische Fähigkeiten.",
			"Zumindest so designerisch, wie es ein Terminal als Schnittstelle zulässt.",
			"Dann würde ich sagen, los gehts",
			"", #ist wichtig, sonst wird zu schwarz gefadet bei letzer Zeile
			]

func _physics_process(delta: float) -> void:
	if line_counter == 0:
		await wait(1)
	label.visible_characters += SPEED

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
		if line_counter == 2:
			pseudocode_kohmi.visible = false
			plakat_kohmi.visible = true
		if line_counter == len(lines)-1:
			can_click = false
			await fade_to_black()
			get_tree().change_scene_to_file("res://scenes/grafikfehler.tscn")
	
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
