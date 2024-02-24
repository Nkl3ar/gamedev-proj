extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.volume_db = GameManagerScript.get_adjusted_db_music()
	$Music.play()


