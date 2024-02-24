extends Node2D
@export var lastLevel: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.play()
	GameManagerScript.beatTheGame = lastLevel


