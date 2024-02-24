extends Node
class_name GameManager

const SAVE_FILE = "user://time_table.sav"

var musicVol = 100
var sfxVol = 100
var time: float = 0.0
var beatTheGame = false

var timeArray = [0.0,0.0,0.0]

func sort_ascending(a, b):
	if a == 0.0:
		return true
	if a < b:
		return true
	return false

func save_time():
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ_WRITE)
	if (FileAccess.file_exists(file)):
		timeArray[0] = file.get_float()
		timeArray[1] = file.get_float()
		timeArray[2] = file.get_float()
	timeArray.append(time)
	timeArray.sort_custom(sort_ascending)
	
	file.store_float(timeArray[0])
	file.store_float(timeArray[1])
	file.store_float(timeArray[2])
	
	file.close()

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
			

