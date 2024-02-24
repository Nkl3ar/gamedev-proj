extends CharacterBody2D

class_name Arrow
const SPEED = 100.0
@export var damage: int = 1
@export var Marker2dRotation: int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	$Marker2D.scale.x = Marker2dRotation
	var direction = $Marker2D.scale.x
	velocity.x = direction * SPEED
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body is MainCharacter_Player:
				for child in body.get_children():
					if child is Damageable:
						child.hit(damage)
	if !(body is Arrow):
		queue_free()
	
