extends CharacterBody2D

@export var SPEED = 0
@export var KNOCKBACK = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var pause_movement = false
var attacking = false
var inRange = false

var in_left = false
var in_right = false
var arrow = preload("res://prefabs/Other/arrow.tscn")

func _ready():
	$Marker2D.scale.x*=-1

func _physics_process(delta):
	if not pause_movement:
		if inRange:
			_attack()
		else:
			$Marker2D/Sprite2D/AnimationPlayer.play("idle")
			if not is_on_floor():
				velocity.y += gravity * delta
			move_and_slide()


func _on_animation_player_animation_finished(anim_name):
	pause_movement = false
	attacking = false
	

func _on_damageable_hit_for_damage():
	$Marker2D/Sprite2D/AnimationPlayer.play("hit")
	pause_movement=true
	var direction = $Marker2D.scale.x
	velocity.x = direction * KNOCKBACK
	move_and_slide()
	



func _on_hurtbox_body_entered(body):
	pass

func _call_fire():
	var arrow_instance = arrow.instantiate()
	arrow_instance.Marker2dRotation = $Marker2D.scale.x
	if $Marker2D.scale.x == -1:
		arrow_instance.position = $Marker2D/MarkerFire.position
	else:
		arrow_instance.position = $Marker2D/MarkerFire2.position
	add_child(arrow_instance)

func _attack():
	if in_left:
		$Marker2D.scale.x = -1
	else:
		$Marker2D.scale.x = 1
	$Marker2D/Sprite2D/AnimationPlayer.play("attack")
	pause_movement=true
	attacking = true
	

func _on_player_detect_l_in_range():
	inRange = true
	in_left = true


func _on_player_detect_l_out_range():
	inRange = false
	in_left = false


func _on_player_detect_r_in_range():
	inRange = true
	in_right = true


func _on_player_detect_r_out_range():
	inRange = false
	in_right = false
