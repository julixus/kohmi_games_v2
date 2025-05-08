extends Node

var score_quiz = 0
var question_counter = 1
var label_counter = 0

var questions = [
	{
		"question": "Was bedeutet das Kürzel „HTML“ in der Webentwicklung?",
		"answers": [
			{"text": "HyperText Markup Language", "is_true": true},
			{"text": "High-Tech Machine Language", "is_true": false},
			{"text": "Hybrid Template Modeling Language", "is_true": false}
		]
	},
	{
		"question": "Welches dieser Programme wird typischerweise zur Bildbearbeitung verwendet?",
		"answers": [
			{"text": "Adobe Photoshop", "is_true": true},
			{"text": "Microsoft Excel", "is_true": false},
			{"text": "Visual Studio Code", "is_true": false}
		]
	},
	{
		"question": "Was macht eine „if“-Anweisung in einer Programmiersprache?",
		"answers": [
			{"text": "Sie führt Code nur unter bestimmten Bedingungen aus", "is_true": true},
			{"text": "Sie startet einen Countdown", "is_true": false},
			{"text": "Sie zeigt ein Bild an", "is_true": false}
		]
	},
	{
		"question": "Welche Farbe entsteht durch das Mischen von Rot und Grün in der additiven Farbmischung (z.B. bei Bildschirmen)?",
		"answers": [
			{"text": "Gelb", "is_true": true},
			{"text": "Blau", "is_true": false},
			{"text": "Violett", "is_true": false}
		]
	},
	{
		"question": "Welche der folgenden Programmiersprachen ist besonders beliebt für Webentwicklung?",
		"answers": [
			{"text": "JavaScript", "is_true": true},
			{"text": "C", "is_true": false},
			{"text": "Assembly", "is_true": false}
		]
	},
	{
		"question": "Was ist ein „Responsive Design“?",
		"answers": [
			{"text": "Ein Design, das sich an verschiedene Bildschirmgrößen anpasst", "is_true": true},
			{"text": "Eine Webseite, die Fragen beantwortet", "is_true": false},
			{"text": "Ein besonders schnelles Website-Layout", "is_true": false}
		]
	},
	{
		"question": "Wie nennt man den Bereich, in dem sich Technik, Gestaltung und Benutzererfahrung überschneiden?",
		"answers": [
			{"text": "User Interface / User Experience (UI/UX)", "is_true": true},
			{"text": "Technische Mechanik", "is_true": false},
			{"text": "Datenanalyse", "is_true": false}
		]
	},
	{
		"question": "Welche Datei-Endung gehört zu einer typischen Videodatei?",
		"answers": [
			{"text": ".mp4", "is_true": true},
			{"text": ".txt", "is_true": false},
			{"text": ".csv", "is_true": false}
		]
	},
	{
		"question": "Welcher dieser Berufe ist KEIN typischer Beruf für Absolventen von Media Engineering?",
		"answers": [
			{"text": "Tierarzt", "is_true": true},
			{"text": "Interaction Designer", "is_true": false},
			{"text": "Frontend Developer", "is_true": false}
		]
	},
	{
		"question": "Wozu dient ein Mikrocontroller wie der Arduino?",
		"answers": [
			{"text": "Zum Steuern kleiner technischer Projekte, z.B. in Robotik", "is_true": true},
			{"text": "Zum Schreiben von E-Mails", "is_true": false},
			{"text": "Zum Erstellen von Videos", "is_true": false}
		]
	}
];

var shuffled_answers = questions[0].answers
