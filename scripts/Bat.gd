extends CharacterBody2D

const SPEED = 50.0

func _physics_process(delta):
	$Marker2D/Sprite2D/AnimationPlayer.play("fly")
	var direction = $Marker2D.scale.x
	velocity.x = direction * SPEED
	
	move_and_slide()




func _on_hurtbox_body_entered(body):
	$Marker2D.scale.x*=-1
