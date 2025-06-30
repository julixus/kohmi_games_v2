extends Node2D

@onready var label: RichTextLabel = $VBoxContainer/Label
@onready var sprecher: Label = $VBoxContainer/Sprecher
@onready var color_rect: ColorRect = $ColorRect
@onready var area_2d: Area2D = $Area2D
@onready var vsp: VideoStreamPlayer = $VideoStreamPlayer


var can_click = true
var js = Engine.get_singleton("JavaScriptBridge")
const SPEED = 1
var line_counter = 0
			#0
var lines = ["Einwandfreie Arbeit Kollege, das hätte ich selbst kaum besser machen können.",
			"Die zweite Frage war schon echt hart, oder?",
			"Wie dem auch sei, ich muss dir ein Geheimnis verraten.",
			"Ich hatte schon von Anfang an etwas mehr Kontrolle als ich dir gesagt habe.",
			"Du weißt ja, ich bin für den Studiengang Media Engineering an der TH Nürnberg zuständig.",
			"Und einer meiner Aufgaben ist es, angehende Studierende anhand ihrer Fähigkeiten und ihres Wissens zu bewerten.",
			"Ich erstelle also ein Zertifikat zu den Testpersonen, auf dem steht, wie gut sie für den Studiengang geeignet sind.",
			"Und ich hatte die ganze Zeit genug Kontrolle, um deine Ergebnisse festzuhalten und dich zu bewerten.",
			"Und lass mich dir sagen, du bist gar nicht schlecht!",
			"Ich schicke dir gleich einen QR Code, über den du dein Zertifikat anschauen kannst.",
			"Falls es nicht deinen Hoffnungen entspricht, keine Sorge, der Algorithmus für die Einschätzung von Personen ist nicht fehlerfrei.",
			"In diesem Fall: Zeig gerne, dass ich falsch lag!",
			"Ansonsten natürlich nochmal vielen Dank für deine Hilfe, der Virus ist gelöscht und ich werde mir als aller erstes ein neues Antivirus Programm installieren.",
			"Falls du jetzt Fragen über Media Engineering oder die TH Nürnberg hast, kannst du mich gerne fragen. Vielleicht kann ich dir ja weiterhelfen!",
			"Ansonsten hoffe ich, wir sehen uns im Studium wieder!",
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
	
	vsp.stream = load("res://res/Animations/Cycles-kohmi-freuen.ogv")
	vsp.loop = false
	vsp.play()
	
	await wait(1)
	label.text = lines[line_counter]

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and can_click:
		next_line()
		if line_counter == 0:
			vsp.stream = load("res://res/Animations/Cycles-kohmi-freuen.ogv")
			vsp.loop = false
			vsp.play()
		if line_counter == 5:
			vsp.stream = load("res://res/Animations/Cycles-Kohmi-thinking.ogv")
			vsp.loop = false
			vsp.play()
		if line_counter == 8:
			vsp.stream = load("res://res/Animations/Cycles-kohmi-approval.ogv")
			vsp.loop = false
			vsp.play()
		if line_counter == 10:
			vsp.stream = load("res://res/Animations/Cycles-kohmi-disapproval.ogv")
			vsp.loop = false
			vsp.play()
		if line_counter == 12:
			vsp.stream = load("res://res/Animations/Cycles-kohmi-approval.ogv")
			vsp.loop = false
			vsp.play()
		if line_counter == 14:
			vsp.stream = load("res://res/Animations/Cycles-kohmi-wave.ogv")
			vsp.loop = false
			vsp.play()
		if line_counter == len(lines)-1:
			can_click = false
			await fade_to_black()
			var message = [
				{"name": Global.player_name},
				{"game": "Pseudocode", "score": Global.pseudocode_score},
				{"game": "Grafikfehler", "score": Global.grafikfehler_score},
				{"game": "Quiz", "score": Global.quiz_score},
			]
			var final_msg = JSON.stringify(message)
			js.eval('window.parent.postMessage('+final_msg+', "*");')
		
	
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
