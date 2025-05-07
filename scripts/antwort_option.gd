extends Button

@export var option_id = 0
var is_true


var question1 = ["f1", "a1-1", "a1-2", "a1-3"]
var question2 = ["f2", "a2-1", "a2-2", "a2-3"]
var question3 = ["f3", "a3-1", "a3-2", "a3-3"]

var questions = Global.questions
func _ready() -> void:
	text = questions[Global.question_counter].answers[option_id-1].text

func _on_pressed() -> void:
	if questions[Global.question_counter].answers[option_id-1].is_true:
		Global.score_quiz =+ 1
	Global.question_counter
	print("reload")
	print(Global.question_counter)
	get_tree().reload_current_scene()

	
