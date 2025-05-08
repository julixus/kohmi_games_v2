extends Node

var score_quiz = 0
var question_counter = 1
var label_counter = 0

var questions = [{"question": "test1?", "answers": 
					[{"text": "a1True", "is_true" : true}, {"text" : "a2", "is_true" : false}, {"text" : "a3", "is_true" : false}]},
				{"question": "test2?", "answers": 
					[{"text": "a4True", "is_true" : true}, {"text" : "a5", "is_true" : false}, {"text" : "a6", "is_true" : false}]},
				{"question": "test3?", "answers": 
					[{"text": "a7True", "is_true" : true}, {"text" : "a8", "is_true" : false}, {"text" : "a9", "is_true" : false}]},]

var shuffled_answers = questions[0].answers
