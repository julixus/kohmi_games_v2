extends Button

@export var option_id = 0
var is_true

var questions = Global.questions
var question_counter = Global.question_counter

func _ready() -> void:
	
	text = Global.shuffled_answers[option_id-1].text

func _on_pressed() -> void:
	if Global.shuffled_answers[option_id-1].is_true:
		Global.score_quiz += 1
	print("länge: ", len(questions))
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
	
		

	
