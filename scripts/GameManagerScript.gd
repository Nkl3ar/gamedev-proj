extends Node
class_name GameManager

var musicVol = 100
var sfxVol = 100
func level_restart():
	get_tree().reload_current_scene()

func get_adjusted_db_music() -> float:
	return 1.0

func get_adjusted_db_sfx() -> float:
	return 1.0

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

	
func _input(event):
	if event.is_action_pressed("pause"):
			get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
			

