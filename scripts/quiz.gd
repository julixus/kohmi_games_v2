extends Node
var style_right = StyleBoxTexture.new()
var style_wrong = StyleBoxTexture.new()
var counter = 0
var shuffled_all
var score = 0
@export var option_id = 0
@onready var option_1: Button = $"VBoxContainer/Antwort Option"
@onready var option_3: Button = $"VBoxContainer/Antwort Option3"
@onready var option_2: Button = $"VBoxContainer/Antwort Option2"
@onready var frage: Label = $Frage
@onready var score_label: Label = $Score



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
	frage.text = "> [" + str(counter+1) + "/" +str(len(shuffled_all)) + "] " + shuffled_all[counter].question
	

func load_answers():
	option_1.text = "A. " + shuffled_all[counter].answers[0].text
	option_2.text = "B. " + shuffled_all[counter].answers[1].text
	option_3.text = "C. " + shuffled_all[counter].answers[2].text
	
func _on_antwort_option_pressed():
	handle_option_pressed(1)

func _on_antwort_option_3_pressed() -> void:
	handle_option_pressed(3)

func _on_antwort_option_2_pressed() -> void:
	handle_option_pressed(2)
	
func handle_option_pressed(index):
	var option = str_to_var("option_" + str(index))
	print(option)
	if shuffled_all[counter].answers[index - 1].is_true:
		score = score + 1
		option.add_theme_stylebox_override("normal", style_right)
		option.add_theme_stylebox_override("hover", style_right)
	else:
		option.add_theme_color_override("normal", style_wrong)
		option.add_theme_color_override("hover", style_wrong)
	counter = counter + 1
	score_label.text = str(score)
	await wait(1)
	option.remove_theme_stylebox_override("normal")
	option.remove_theme_stylebox_override("hover")
	new_question()
	load_answers()
	
func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
