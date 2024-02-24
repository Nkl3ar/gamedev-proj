extends CharacterBody2D

@export var SPEED = 75.0
var KNOCKBACK = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var pause_movement = false
var attacking = false
var inRange = false
const ATTACK_VELOCITY = 150.0

func _ready():
	$Marker2D.scale.x*=-1

func _physics_process(delta):
	if not pause_movement:
		if inRange:
			var direction = $Marker2D.scale.x
			velocity.x = direction * ATTACK_VELOCITY
			pause_movement = true
			$Marker2D/Sprite2D/AnimationPlayer.play("attack")
			pause_movement = true
			attacking = true
			$Marker2D/Hurtbox.enable_damage()
			$Marker2D/Attack.play()
		else:
			$Marker2D/Hurtbox.disable_damage()
			$Marker2D/Sprite2D/AnimationPlayer.play("walk")
			if not is_on_floor():
				velocity.y += gravity * delta
			var direction = $Marker2D.scale.x
			velocity.x = direction * SPEED
			move_and_slide()


func _on_animation_player_animation_finished(anim_name):
	pause_movement = false
	attacking = false
	

func _on_damageable_hit_for_damage():
	$Marker2D/Sprite2D/AnimationPlayer.play("hit")
	$Marker2D/Attack.stop()
	$Marker2D/Hit.play()
	pause_movement=true
	var direction = $Marker2D.scale.x
	velocity.x = direction * KNOCKBACK
	move_and_slide()
	



func _on_hurtbox_body_entered(body):
	if !attacking:
		$Marker2D.scale.x*=-1


func _on_player_detect_in_range():
	inRange = true

func _on_player_detect_out_range():
	inRange = false
