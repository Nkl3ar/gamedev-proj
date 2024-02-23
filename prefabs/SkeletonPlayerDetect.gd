extends Area2D


signal in_range

signal out_range



func _on_body_entered(body):
	if body is MainCharacter_Player:
			in_range.emit()


func _on_body_exited(body):
	if body is MainCharacter_Player:
			out_range.emit()
