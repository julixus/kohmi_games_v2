extends Label

var questions = Global.questions

func _ready() -> void:
	if name == "Frage":
		text = questions[Global.question_counter].question
