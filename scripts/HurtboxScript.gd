extends Area2D

@export var damage: int = 10
@export var detectPlayer: bool = true
var afflictDamage: bool = true

func enable_damage():
	afflictDamage=true
func disable_damage():
	afflictDamage=false

func _on_body_entered(body):
	if afflictDamage:
		if detectPlayer:
			if body is MainCharacter_Player:
				for child in body.get_children():
					if child is PDamageable:
						child.hit(damage)
		else:
			if !(body is MainCharacter_Player):
				for child in body.get_children():
					if child is Damageable:
						child.hit(damage)
