extends Control
var sfx_index: int
var music_index: int
func _ready():
	sfx_index = AudioServer.get_bus_index("Sfx")
	music_index = AudioServer.get_bus_index("Music")
	

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/Forest.tscn")


func _on_info_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()


func _on_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(value))


func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(music_index, linear_to_db(value))
