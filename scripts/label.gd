extends Label

var questions = Global.questions

func _ready() -> void:
	if name == "Frage":
		text = questions[Global.label_counter].question
	if name == "Score":
		text = var_to_str(Global.score_quiz)
		Global.label_counter += 1
