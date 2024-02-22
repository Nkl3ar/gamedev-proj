extends CharacterBody2D


const SPEED = 300.0
const ROLL_SPEED = 280.0
const LOCK_SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Exists so idle animation doesnt play over the jump animation
var jumped = false

#active rolling animation
@export var rollingAnimActiveFrame: int = 0

var headCrushed = false


func _sprite_direction_flip(direction):
	if direction == 1:
		$Marker2D.scale.x = 1
	else:
		$Marker2D.scale.x = -1

func _physics_process(delta):
	var direction = $Marker2D.scale.x
	var inputAxis = Input.get_axis("move-left", "move-right")
	var locked = Input.is_action_pressed("lock")
	if !locked:
		direction = inputAxis
	jumped=false
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	
		
	if Input.is_action_just_pressed("jump") and locked and is_on_floor() and !rollingAnimActiveFrame:
		rollingAnimActiveFrame = 1
		$Marker2D/Sprite2D/AnimationPlayer.play("roll")
		if inputAxis == 0:
			inputAxis = direction
		velocity.x = inputAxis * ROLL_SPEED
		
	# Handle jump.
	elif Input.is_action_just_pressed("jump") and is_on_floor() and !rollingAnimActiveFrame:
		velocity.y = JUMP_VELOCITY
		$Marker2D/Sprite2D/AnimationPlayer.play("jump")
		$Marker2D/Sprite2D/AnimationPlayer.queue("jump_midair")
		jumped=true
		

	if rollingAnimActiveFrame:
		if rollingAnimActiveFrame == 6:
			rollingAnimActiveFrame = 0
		elif rollingAnimActiveFrame == 5:
			if inputAxis:
				velocity.x = inputAxis * LOCK_SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
	elif headCrushed and Input.is_action_pressed("jump") and locked:
		if inputAxis == 0:
			inputAxis = direction
		velocity.x = inputAxis * ROLL_SPEED
		rollingAnimActiveFrame = 1
		$Marker2D/Sprite2D/AnimationPlayer.play("roll")
	elif inputAxis:
		
		var anim = "walk"
		if locked:
			velocity.x = inputAxis * LOCK_SPEED
			if inputAxis-direction!=0:
				anim = "lockon_walk_backwards"
			else:
				anim = "lockon_walk"
		else:
			velocity.x = inputAxis * SPEED
			_sprite_direction_flip(inputAxis)
		if is_on_floor() and jumped==false:
			$Marker2D/Sprite2D/AnimationPlayer.play(anim)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and jumped==false:
			$Marker2D/Sprite2D/AnimationPlayer.play("idle")

	move_and_slide()




func _on_roll_failure_detector_body_exited(body):
	if body is TileMap and is_on_floor():
		headCrushed = false


func _on_roll_failure_detector_body_entered(body):
	if body is TileMap and is_on_floor():
		headCrushed = true


func _on_animation_player_animation_finished(anim_name):
	rollingAnimActiveFrame = 0
