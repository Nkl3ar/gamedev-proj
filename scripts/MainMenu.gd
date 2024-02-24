extends Control



func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/Forest.tscn")


func _on_info_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
