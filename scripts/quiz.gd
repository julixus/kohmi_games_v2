extends Node
var style_right = StyleBoxTexture.new()
var style_wrong = StyleBoxTexture.new()
var counter = 0
var shuffled_all
var score = 0
var option_buttons
var question_order = [0, 1, 2]
var can_click = true
const MAX_QUESTIONS = 10
var shader_started = false
var shader_time = 0
@export var option_id = 0
@onready var option_1: Button = $"VBoxContainer/Antwort Option"
@onready var option_3: Button = $"VBoxContainer/Antwort Option3"
@onready var option_2: Button = $"VBoxContainer/Antwort Option2"
@onready var frage: Label = $Frage
@onready var score_label: Label = $Score
@onready var help_ui: Control = $help_ui
@onready var info_btn: Button = $info_btn
@onready var shader_transition: ColorRect = $shader_transition


func _ready() -> void:
	option_buttons = [option_1, option_2, option_3]
	score_label.text = str(score)
	load_textures()
	shuffle_all()
	new_question()
	load_answers()
	
func _process(delta: float) -> void:
	if shader_started:
		shader_transition.visible = true
		shader_time += delta
		shader_transition.material.set_shader_parameter("u_time", shader_time)
	
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
	frage.text = "> [" + str(counter+1) + "/" +str(MAX_QUESTIONS) + "] " + shuffled_all[counter].question
	

func load_answers():
	question_order.shuffle()
	option_1.text = "A. " + shuffled_all[counter].answers[question_order[0]].text
	option_2.text = "C. " + shuffled_all[counter].answers[question_order[1]].text
	option_3.text = "B. " + shuffled_all[counter].answers[question_order[2]].text
		
func _on_antwort_option_pressed():
	if (counter < MAX_QUESTIONS and can_click):
		handle_option_pressed(0)

func _on_antwort_option_3_pressed() -> void:
	if (counter < MAX_QUESTIONS and can_click):
		handle_option_pressed(2)

func _on_antwort_option_2_pressed() -> void:
	if (counter < MAX_QUESTIONS and can_click):	
		handle_option_pressed(1)
	
func handle_option_pressed(index):	
	if shuffled_all[counter].answers[question_order[index]].is_true:
		score += 1
	reveal_options()
	counter += 1
	score_label.text = str(score)
	await wait(1.5)
	print(counter)
	if (counter < MAX_QUESTIONS):
		new_question()
		load_answers()
	else:
		print("Das waren alle Fragen")
		Global.quiz_score = score
		shader_started = true
		print("shader started")
		shader_transition.material.set_shader_parameter("u_time", 0.0)
		await wait(3)
		get_tree().change_scene_to_file("res://scenes/outro.tscn")
	
func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

func reveal_options():
	var i = 0
	for option in option_buttons:
		if shuffled_all[counter].answers[question_order[i]].is_true:
			option.add_theme_stylebox_override("normal", style_right)
			option.add_theme_stylebox_override("hover", style_right)
		else:
			option.add_theme_stylebox_override("normal", style_wrong)
			option.add_theme_stylebox_override("hover", style_wrong)
			option.add_theme_color_override("font_color", Color(70, 0, 0))
			option.add_theme_color_override("font_hover_color", Color(70, 0, 0))
			option.add_theme_color_override("font_focus_color", Color(70, 0, 0))
			option.add_theme_color_override("font_disabled_color", Color(70, 0, 0))
		i += 1
	can_click = false #verhindert spammen von Anworten, ansonsten von zb Frage 3 auf Frage 10 instant
	await wait(1.5)
	can_click = true
	for option in option_buttons:
		option.remove_theme_stylebox_override("normal")
		option.remove_theme_stylebox_override("hover")
		option.add_theme_color_override("font_color", Color(0, 70, 0))
		option.add_theme_color_override("font_hover_color", Color(0, 70, 0))
		option.add_theme_color_override("font_focus_color", Color(0, 70, 0))
		option.add_theme_color_override("font_disabled_color", Color(0, 70, 0))

func _on_info_btn_pressed() -> void:
	help_ui.visible = true

func _on_ok_button_pressed() -> void:
	print("ok button toggled")
	help_ui.visible = false
	
