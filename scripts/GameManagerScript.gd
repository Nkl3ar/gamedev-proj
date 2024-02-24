extends Node
class_name GameManager
func level_restart():
	get_tree().reload_current_scene()
	

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

	
func _input(event):
	if event.is_action_pressed("pause"):
			get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
			

