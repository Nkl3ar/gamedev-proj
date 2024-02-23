extends CharacterBody2D

class_name MainCharacter_Player 

const SPEED = 300.0
const ROLL_SPEED = 280.0
const LOCK_SPEED = 200.0
const JUMP_VELOCITY = -400.0
const SLAM_VELOCITY = 800.0
const ATTACK_VELOCITY = 100.0
const ATTACK_1_GRAVITY = -150.0
const ATTACK_2_GRAVITY = -200.0
const ATTACK_3_GRAVITY = -150.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Exists so idle animation doesnt play over animations
var pause_idle = false
var pause_movement=false
var slammed=false

#active rolling animation
@export var rollingAnimActiveFrame: int = 0

var headCrushed = false
var fallTimer = 0.4

func _ready():
	rollingAnimActiveFrame = 0
	$Marker2D/Sprite2D/AnimationPlayer.play("RESET")
	
func _process(delta):
	if not is_on_floor() and pause_movement:
		fallTimer -= delta
	else:
		fallTimer = 0.4
	if fallTimer<0 and !pause_movement:
		$Marker2D/Sprite2D/AnimationPlayer.play("jump_midair")
		pause_idle = false

func _sprite_direction_flip(direction):
	if direction == 1:
		$Marker2D.scale.x = 1
	else:
		$Marker2D.scale.x = -1

func _physics_process(delta):
	var direction = $Marker2D.scale.x
	var inputAxis = Input.get_axis("move-left", "move-right")
	var locked = Input.is_action_pressed("lock")
	slammed=false
	if !locked and inputAxis != 0:
		direction = inputAxis
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	#needs to be a one and done
	if Input.is_action_just_pressed("jump") and !rollingAnimActiveFrame and is_on_floor():
		#Roll
		if locked:
			rollingAnimActiveFrame = 1
			pause_movement=true
			$Marker2D/Sprite2D/AnimationPlayer.play("roll")
			if inputAxis == 0:
				inputAxis = direction
			velocity.x = inputAxis * ROLL_SPEED
			pause_idle=true
		#Jump
		else:
			velocity.y = JUMP_VELOCITY
			$Marker2D/Sprite2D/AnimationPlayer.play("jump")
			pause_idle=true
	
	if Input.is_action_pressed("attack-1") and Input.is_action_pressed("jump") and locked and !rollingAnimActiveFrame and not is_on_floor():
		velocity.y = SLAM_VELOCITY
		$Marker2D/Sprite2D/AnimationPlayer.stop()
		$Marker2D/Sprite2D/AnimationPlayer.play("slam")
		pause_movement=false
		slammed=true
		
		
		
	if rollingAnimActiveFrame:
		if rollingAnimActiveFrame == 6:
			rollingAnimActiveFrame = 0
			pause_movement=false
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
	elif Input.is_action_just_pressed("attack-1") and !pause_movement and !slammed:
		inputAxis = direction
		velocity.x = inputAxis * ATTACK_VELOCITY
		if not is_on_floor():
			velocity.y = ATTACK_1_GRAVITY
		$Marker2D/Sprite2D/AnimationPlayer.play("attack-1")
		pause_idle=true
		pause_movement=true
	elif Input.is_action_just_pressed("attack-2") and !pause_movement:
		inputAxis = direction
		velocity.x = inputAxis * ATTACK_VELOCITY
		if not is_on_floor():
			velocity.y = ATTACK_2_GRAVITY
		$Marker2D/Sprite2D/AnimationPlayer.play("attack-2")
		pause_idle=true
		pause_movement=true
	elif Input.is_action_just_pressed("attack-3") and !pause_movement:
		inputAxis = direction
		velocity.x = inputAxis * ATTACK_VELOCITY
		if not is_on_floor():
			velocity.y = ATTACK_3_GRAVITY
		$Marker2D/Sprite2D/AnimationPlayer.play("attack-3")
		pause_idle=true
		pause_movement=true
	elif inputAxis and !pause_movement:
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
		if is_on_floor() and !pause_idle:
			$Marker2D/Sprite2D/AnimationPlayer.play(anim)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and !pause_idle:
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
	pause_idle=false
	pause_movement=false
