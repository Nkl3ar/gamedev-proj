extends Area2D

@export var level: PackedScene


func _on_body_entered(body):
	if body is MainCharacter_Player:
		get_tree().change_scene_to_packed(level)
