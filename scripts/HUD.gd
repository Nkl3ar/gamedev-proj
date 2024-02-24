extends Node

var time: float = 0.0
var hours: int = 0
var minutes: int = 0
var seconds: int = 0

func _process(delta):
	time+=delta
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	hours = fmod(time, 216000) / 3600
	$Time/Panel/Hours.text = "%03d:" % hours
	$Time/Panel/Minutes.text = "%02d:" % minutes
	$Time/Panel/Seconds.text = "%02d" % seconds

func _on_p_damageable_update_health(health):
	$Health/HealthValue.text = str(health)


func _on_player_update_charge(charge):
	$Charge/ChargeValue.text = str(charge) + "%"
