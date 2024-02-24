extends Node
class_name GameManager

const SAVE_FILE = "user://hi_time_table.sav"

var musicVol = 50
var sfxVol = 50
var time: float = 0.0
var beatTheGame = false
var timeArray = []

func sort_ascending(a, b):
	if b == 0.0:
		return true
	if a < b:
		return true
	return false

func save_time():
	print(time)
	if beatTheGame:
		var file = FileAccess.open(SAVE_FILE, FileAccess.READ_WRITE)
		if (FileAccess.file_exists(SAVE_FILE)):
			print("passed")
			timeArray = file.get_var()
			timeArray.append(time)
		else:
			file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
			timeArray = [time]
		
		timeArray.sort_custom(sort_ascending)
		file.store_var(timeArray)
		print(timeArray)
		
		file.close()
	beatTheGame = false
	print(timeArray)

func get_time():
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	if (FileAccess.file_exists(SAVE_FILE)):
		timeArray = file.get_var()
		timeArray.sort_custom(sort_ascending)
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
			

