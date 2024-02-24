extends Node2D

var triggered = false
@export var walls: Array[Vector2]
@export var tilemap: TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if !triggered and body is MainCharacter_Player:
		$AudioStreamPlayer.play()
		triggered = true
		for im in walls:
			tilemap.set_cell(0, im, -1, Vector2(0, 0))
