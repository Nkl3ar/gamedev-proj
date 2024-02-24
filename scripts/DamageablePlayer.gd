extends Node

class_name PDamageable
@export var health = 1

var invul=false
var invul_period=5.0

func apply_invul(wanted_invul_period):
	invul_period=wanted_invul_period
	invul=true

func _process(delta):
	if invul:
		invul_period-=delta
		if invul_period<0:
			invul_period=5.0
			invul=false
			
signal hit_for_damage
signal update_health(health)
func kill_now():
			GameManagerScript.level_restart()
	
	
func hit(damage):
		if !invul:
			if (damage>0):
				hit_for_damage.emit()
			health-=damage
			if(health<=0):
				GameManagerScript.level_restart()
			update_health.emit(health)
			invul=true
