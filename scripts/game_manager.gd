extends Node

var score = 0

@onready var score_label: Label = $Score_Label


func add_point():
	score += 1
	score_label.text = "WoW " + str(score) + " Coins!"
