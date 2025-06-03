extends Node
var style_right
var style_wrong
var counter = 0
var shuffled_all
@export var option_id = 0
@onready var option_1: Button = $"VBoxContainer/Antwort Option"
@onready var option_3: Button = $"VBoxContainer/Antwort Option3"
@onready var option_2: Button = $"VBoxContainer/Antwort Option2"
@onready var frage: Label = $Frage


func _ready() -> void:
	load_textures()
	shuffle_all()
	new_question()
	load_answers()
	
func load_textures():
	style_right.texture = load("res://res/Quiz-richtig.webp")
	style_right.content_margin_left = 20
	style_wrong.texture = load("res://res/Quiz-Falsch.webp")
	style_wrong.content_margin_left = 20
	
func shuffle_all():
	Global.shuffled_all = Global.questions.duplicate()
	Global.shuffled_all.shuffle()
	shuffled_all = Global.shuffled_all

func new_question():
	frage.text = shuffled_all[counter].question
	

func load_answers():
	option_1.text = shuffled_all[counter].answers[0].text
	option_2.text = shuffled_all[counter].answers[1].text
	option_3.text = shuffled_all[counter].answers[2].text
	
func _on_antwort_option_pressed():
	if shuffled_all[counter].answers[0].is_true
