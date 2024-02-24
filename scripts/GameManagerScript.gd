extends Node
class_name GameManager

const SAVE_FILE = "user://hi_time_table.sav"

var musicVol = 50
var sfxVol = 50
var time: float = 0.0
var beatTheGame = false
var bestTime = 0.0


func save_time():
	print(time)
	if beatTheGame:
		var file = FileAccess.open(SAVE_FILE, FileAccess.READ_WRITE)
		if (FileAccess.file_exists(SAVE_FILE)):
			bestTime = file.get_float()
			if (bestTime>time):
				file.close()
				file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
				file.store_float(time)
		else:
			file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
			file.store_float(time)
	
		
		file.close()
	beatTheGame = false

func get_time():
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	if (FileAccess.file_exists(SAVE_FILE)):
		bestTime = file.get_float()
		file.close()
	

func level_restart():
	get_tree().reload_current_scene()


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

	
func _input(event):
	if event.is_action_pressed("pause"):
			get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
			

