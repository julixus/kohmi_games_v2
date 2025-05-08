extends Label

var questions = Global.questions

func _ready() -> void:
	if name == "Frage":
		print("label counter: ", Global.label_counter)
		if len(questions) > Global.label_counter:
			text = questions[Global.label_counter].question
		else:
			text = questions[len(questions)-1].question
	if name == "Score":
		text = var_to_str(Global.score_quiz)
		Global.label_counter += 1
