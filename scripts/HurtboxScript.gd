extends Area2D

@export var damage: int = 10
@export var detectPlayer: bool = true

func _on_body_entered(body):
	if detectPlayer:
		if body is MainCharacter_Player:
			for child in body.get_children():
				if child is Damageable:
					child.hit(damage)
	else:
		if body != get_parent():
			for child in body.get_children():
				if child is Damageable:
					child.hit(damage)
