extends Control
var sfx_index: int
var music_index: int
func _ready():
	sfx_index = AudioServer.get_bus_index("Sfx")
	music_index = AudioServer.get_bus_index("Music")
	$MarginContainer/VBoxContainer/SFX.value = GameManagerScript.sfxVol
	$MarginContainer/VBoxContainer/Music.value = GameManagerScript.musicVol
	GameManagerScript.get_time()
	GameManagerScript.time=0.0
	

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/Forest.tscn")


func _on_info_pressed():
	get_tree().change_scene_to_file("res://scenes/Info.tscn")

func _on_speedrun_pressed():
	get_tree().change_scene_to_file("res://scenes/Speedruns.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_sfx_value_changed(value):
	GameManagerScript.sfxVol = value
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(value))


func _on_music_value_changed(value):
	GameManagerScript.musicVol = value
	AudioServer.set_bus_volume_db(music_index, linear_to_db(value))


