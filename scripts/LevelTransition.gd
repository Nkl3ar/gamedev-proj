extends Area2D

@export var level: PackedScene

func _ready():
	$Sprite2D/AnimationPlayer.play("portal")
func _on_body_entered(body):
	if body is MainCharacter_Player:
		GameManagerScript.save_time()
		get_tree().change_scene_to_packed(level)
