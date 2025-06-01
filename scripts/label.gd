extends Label

var questions = Global.questions

func _ready() -> void:
	if name == "Frage":
		print("label counter: ", Global.label_counter)
		if len(questions) > Global.label_counter:
			text = "> [" + str(Global.label_counter+1) + "/" + str(len(questions)) + "] " + questions[Global.label_counter].question
		else:
			text = "> [" + str(Global.label_counter) + "/" + str(len(questions)) + "] " + questions[len(questions)-1].question
	if name == "Score":
		text = var_to_str(Global.score_quiz)
		if (Global.label_counter < len(questions)):
			Global.label_counter += 1
