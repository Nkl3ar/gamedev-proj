extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is MainCharacter_Player:
		for child in body.get_children():
					if child is PDamageable:
						child.hit(9001)

