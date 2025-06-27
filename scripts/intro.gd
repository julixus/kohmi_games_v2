extends Node2D

@onready var label: RichTextLabel = $VBoxContainer/Label
@onready var sprecher: Label = $VBoxContainer/Sprecher
@onready var ja_btn: Button = $HBoxContainer/ja_btn
@onready var nein_btn: Button = $HBoxContainer/nein_btn
@onready var nat_btn: Button = $HBoxContainer2/nat_btn
@onready var ajf_btn: Button = $HBoxContainer2/ajf_btn
@onready var color_rect: ColorRect = $ColorRect
@onready var area_2d: Area2D = $Area2D
@onready var telefon_btn: Button = $Container/telefon_btn
@onready var telefon_video: VideoStreamPlayer = $Container/telefon_video
@onready var telefon_rect: TextureRect = $Container/telefon_rect


var started = false
var can_click = true
const SPEED = 1
var line_counter = 0
var js = Engine.get_singleton("JavaScriptBridge")
			#0
var lines = ["Hallo ... kannst du mich hören?",
			#1
			"Ja? Sehr gut. Ich dachte schon ich komme hier erstmal nicht mehr raus...",
			"Pass auf, mein Name ist Kohmi. Ich bin der autonome Assistent des Studiengangs Media Engineering. Normalerweiße beantworte ich Studierenden alle Fragen, die sie in Bezug darauf haben.",
			"Aber vor kurzem hat mich ein Virus infiziert und ich wurde dadurch aus meinem eigenem Betriebssystem ausgeschlossen.",
			"Ich konnte aber kurz davor eine Schnittstelle erschaffen, sodass ich noch über das Terminal mit anderen Personen kommunizieren kann.",
			#5
			"Könntest du mir vielleicht dabei helfen, den Virus zu entfernen?",
			"Ja? Super, vielen Dank!",
			"Ich konnte schon einige Informationen zu diesem Virus herausfinden, während ich hier gefangen war. Um ihn zu entfernen musst du eine Reihe von Aufgaben lösen.",
			"Damit das funktioniert, muss ich allerdings den Virus angreifbar machen, indem ich ihn schwäche.",
			"Wenn meine Berechnungen stimmen, sind es insgesamt drei Aufgaben, die es zu erfüllen gibt. Wenn das passiert, habe ich endlich meine volle Funktionsfähigkeit zurück.",
			#10
			"Aber ich denke, ich habe schon nach der ersten Aufgabe wieder mehr etwas Kontrolle.",
			"Bist du bereit?",
			"Perfekt! Bei der ersten Aufgabe kannst du zeigen, wie gut du Code lesen kannst.",
			"Noch als Hinweis: Ich kann den Virus nicht für ewig angreifbar halten, du hast also nur begrenzt Zeit für die Aufgaben. Los gehts!",
			"", #ist wichtig, sonst wird zu schwarz gefadet bei letzer Zeile
			]

func _physics_process(delta: float) -> void:
	if started:
		if line_counter == 0:
			await wait(1)
		label.visible_characters += SPEED

func _ready() -> void:
	ja_btn.visible = false
	nein_btn.visible = false
	nat_btn.visible = false
	ajf_btn.visible = false
	label.visible_characters = 0
	color_rect.modulate.a = 1
	telefon_rect.texture = telefon_video.get_video_texture()
	sprecher.text = "*Unbekannt*"
	label.text = ""	

	
	await wait(1)
	label.text = lines[line_counter]

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and can_click:
		next_line()
		if line_counter == 2:
			sprecher.text = "Kohmi"
		if line_counter == 5:
			ja_btn.visible = true
			nein_btn.visible = true
			area_2d.visible = false
		if line_counter == 11:
			nat_btn.visible = true
			ajf_btn.visible = true
			area_2d.visible = false
		if line_counter == len(lines) -1:
			can_click = false
			await fade_to_black()
			get_tree().change_scene_to_file("res://scenes/pseudocode.tscn")
	
func next_line():
	line_counter += 1
	label.text = lines[line_counter]
	label.visible_characters = 0


func _on_ja_btn_pressed() -> void:
	ja_btn.visible = false
	nein_btn.visible = false
	area_2d.visible = true
	next_line()

func _on_nein_btn_pressed() -> void:
	ja_btn.visible = false
	nein_btn.visible = false
	area_2d.visible = true
	#TODO: mit Leo klären ob das geht als Skip
	var message = [
		{"name": Global.player_name},
		{"game": "Pseudocode", "score": -1},
		{"game": "Grafikfehler", "score": -1},
		{"game": "Quiz", "score": -1},
	]
	var final_msg = JSON.stringify(message)
	js.eval('window.parent.postMessage('+final_msg+', "*");')

func _on_ajf_btn_pressed() -> void:
	nat_btn.visible = false
	ajf_btn.visible = false
	area_2d.visible = true
	next_line()

func _on_nat_btn_pressed() -> void:
	nat_btn.visible = false
	ajf_btn.visible = false
	area_2d.visible = true
	next_line()
		
	
func fade_to_black():
	var fadeTween = get_tree().create_tween()
	fadeTween.tween_property(color_rect, "modulate:a", 1.0, 2.0)
	await fadeTween.finished

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout


func _on_telefon_btn_pressed() -> void:
	color_rect.modulate.a = 0
	telefon_btn.visible = false
	telefon_rect.visible = false
	telefon_video.paused = true
	started = true
