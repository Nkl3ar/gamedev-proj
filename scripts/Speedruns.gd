extends Node

var time
var seconds
var minutes
var hours

func _ready():
	var j = 0
	for i in GameManagerScript.timeArray:
		time = i
		seconds = fmod(time, 60)
		minutes = fmod(time, 3600) / 60
		hours = fmod(time, 216000) / 3600
		if j == 0:
			$Panel/VBoxContainer/Fast1.text = "\n" + "%03d:" % hours + "%02d:" % minutes + "%02d" % seconds + "\n" + "\n"
		if j == 1:
			$Panel/VBoxContainer/Fast2.text = "\n" + "%03d:" % hours + "%02d:" % minutes + "%02d" % seconds + "\n" + "\n"
		if j == 2:
			$Panel/VBoxContainer/Fast3.text = "\n" + "%03d:" % hours + "%02d:" % minutes + "%02d" % seconds + "\n" + "\n"
		j = j + 1
		if j == 3: 
			break

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
