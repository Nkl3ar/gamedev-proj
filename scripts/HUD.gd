extends Node

var hours: int = 0
var minutes: int = 0
var seconds: int = 0
@export var sbLow: StyleBoxFlat
@export var sbMed: StyleBoxFlat
@export var sbHigh: StyleBoxFlat
@export var sbOC: StyleBoxFlat
func _ready():
	$HealthBar.max_value = 5
	$HealthBar.value = 5
	$ChargeBar.value = 100

func _process(delta):
	GameManagerScript.time+=delta
	seconds = fmod(GameManagerScript.time, 60)
	minutes = fmod(GameManagerScript.time, 3600) / 60
	hours = fmod(GameManagerScript.time, 216000) / 3600
	$Time/Panel/Hours.text = "%03d:" % hours
	$Time/Panel/Minutes.text = "%02d:" % minutes
	$Time/Panel/Seconds.text = "%02d" % seconds

func _on_p_damageable_update_health(health):
	$Health/HealthValue.text = str(health)
	$HealthBar.value=health
	if health<2:
		$HealthBar.add_theme_stylebox_override("fill", sbLow)
	elif health<5:
		$HealthBar.add_theme_stylebox_override("fill", sbMed)
	elif health<6:
		$HealthBar.add_theme_stylebox_override("fill", sbHigh)
	else:
		$HealthBar.add_theme_stylebox_override("fill", sbOC)


func _on_player_update_charge(charge):
	$Charge/ChargeValue.text = str(charge) + "%"
	$ChargeBar.value=charge
	if charge<30:
		$ChargeBar.add_theme_stylebox_override("fill", sbLow)
	else:
		$ChargeBar.add_theme_stylebox_override("fill", sbMed)
