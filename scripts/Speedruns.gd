extends Node

var seconds
var minutes
var hours

func _ready():
	seconds = fmod(GameManagerScript.bestTime, 60)
	minutes = fmod(GameManagerScript.bestTime, 3600) / 60
	hours = fmod(GameManagerScript.bestTime, 216000) / 3600
	$Panel/VBoxContainer/Fast1.text = "\n" + "%03d:" % hours + "%02d:" % minutes + "%02d" % seconds + "\n" + "\n"


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
