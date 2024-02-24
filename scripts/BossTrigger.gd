extends Node2D

@export var boss: Resource
@export var spawnMarker: Marker2D
@export var walls: Array[Vector2]
@export var tilemap: TileMap
@export var tile_index: int
var reset = false
var enemy
var spawned = false
var _tileset
# Called when the node enters the scene tree for the first time.
func _ready():
	_tileset = tilemap.tile_set
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawned and !is_instance_valid(enemy) and !reset:
		reset = true
		$AudioStreamPlayer.play()
		for im in walls:
			tilemap.set_cell(0, im, -1, Vector2(0, 0))
		


func _on_boss_trigger_body_entered(body):
	if !spawned and body is MainCharacter_Player:
		$AudioStreamPlayer.play()
		spawned = true
		enemy = boss.instantiate()
		enemy.position = spawnMarker.position
		add_child(enemy)
		for im in walls:
			tilemap.set_cell(0, im, tile_index, Vector2(0, 0))
		for child in body.get_children():
				if child is PDamageable:
					child.hit(-3)
