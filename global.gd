extends Node

var shuffled_all
var pseudocode_score = 0
var grafikfehler_score = 0
var quiz_score = 0
var player_name = "unchanged name"


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
	},
	{
	"question": "Was ist ein typisches Dateiformat für Audiodateien?",
	"answers": [
		{"text": ".wav", "is_true": true},
		{"text": ".docx", "is_true": false},
		{"text": ".png", "is_true": false}
	]
	},
	{
		"question": "Was ist ein typisches Anwendungsgebiet von Blender?",
		"answers": [
			{"text": "3D-Modellierung und Animation", "is_true": true},
			{"text": "Musikstreaming", "is_true": false},
			{"text": "Textverarbeitung", "is_true": false}
		]
	},
	{
		"question": "Was versteht man unter CSS in der Webentwicklung?",
		"answers": [
			{"text": "Cascading Style Sheets", "is_true": true},
			{"text": "Creative Software Suite", "is_true": false},
			{"text": "Central Server System", "is_true": false}
		]
	},
	{
		"question": "Was beschreibt der Begriff 'Prototyping' im UX-Design?",
		"answers": [
			{"text": "Das Erstellen von Testversionen eines Produkts", "is_true": true},
			{"text": "Das Verschlüsseln von Daten", "is_true": false},
			{"text": "Das Drucken von Handbüchern", "is_true": false}
		]
	},
	{
		"question": "Welche Software wird häufig für Videoschnitt verwendet?",
		"answers": [
			{"text": "Adobe Premiere Pro", "is_true": true},
			{"text": "Google Chrome", "is_true": false},
			{"text": "VLC Media Player", "is_true": false}
		]
	},
	{
		"question": "Was ist die binäre Zahl 1001 in decimal?",
		"answers": [
			{"text": "9", "is_true": true},
			{"text": "5", "is_true": false},
			{"text": "18", "is_true": false}
		]
	},
	{
		"question": "Womit stellt man die Tiefenschärfe bei einer Kamera ein?",
		"answers": [
			{"text": "Mit der Blende", "is_true": true},
			{"text": "Mit der Verschlusszeit", "is_true": false},
			{"text": "Mit dem ISO-Wert", "is_true": false}
		]
	},
	{
		"question": "Was macht ein VPN?",
		"answers": [
			{"text": "Es verbindet Geräte in einem bestehenden Netzwerk mit einem anderen Netzwerk", "is_true": true},
			{"text": "Es dient als Virenscanner", "is_true": false},
			{"text": "Es verbindet IP Adresse und Domäne (z.B. Adresse 8.8.8.8 mit Google.com)", "is_true": false}
		]
	},
];
