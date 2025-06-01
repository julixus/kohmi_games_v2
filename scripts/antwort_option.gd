extends Button

@export var option_id = 0
var is_true

var questions = Global.questions
var question_counter = Global.question_counter
var style_normal
var style_right = StyleBoxTexture.new()
var style_wrong = StyleBoxTexture.new()


func _ready() -> void:
	style_right.texture = load("res://res/Quiz-richtig.webp")
	style_right.content_margin_left = 20
	style_wrong.texture = load("res://res/Quiz-Falsch.webp")
	style_wrong
	style_wrong.content_margin_left = 20
	
	if (option_id == 1):
		text = "A. " + Global.shuffled_answers[option_id-1].text
	elif (option_id == 2):
		text = "B. " + Global.shuffled_answers[option_id-1].text
	else:
		text = "C. " + Global.shuffled_answers[option_id-1].text

func _on_pressed() -> void:
	if Global.shuffled_answers[option_id-1].is_true:
		Global.score_quiz += 1
		add_theme_stylebox_override("normal", style_right)
		add_theme_stylebox_override("hover", style_right)
	else:
		add_theme_stylebox_override("normal", style_wrong)
		add_theme_stylebox_override("hover", style_wrong)
	print("länge: ", len(questions))
	await wait(1)
	remove_theme_stylebox_override("normal")
	remove_theme_stylebox_override("hover")
	shuffle_answers()
	
	if len(questions) > question_counter+1:
		Global.question_counter += 1 
	else:
		print("Keine weiteren Fragen")
	print("counter: ", question_counter)
	get_tree().reload_current_scene()
		
func shuffle_answers():
	Global.shuffled_answers = questions[question_counter].answers.duplicate()
	Global.shuffled_answers.shuffle()
	
func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
