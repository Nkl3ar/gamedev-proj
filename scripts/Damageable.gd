extends Node

class_name Damageable
@export var health = 1
signal hit_for_damage
func hit(damage):
	hit_for_damage.emit()
	health-=damage
	if(health<=0):
		get_parent().queue_free()
