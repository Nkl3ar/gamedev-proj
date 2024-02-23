extends Node

class_name Damageable
@export var health = 1

func hit(damage):
	health-=damage
	if(health<=0):
		get_parent().queue_free()
