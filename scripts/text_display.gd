extends Area2D
class_name TextDisplay

@export var label : Label = null


func _ready():
	if label != null:
		label.hide()


func _on_body_entered(body):
	if body is Player:
		if label != null:
			label.show()


func _on_body_exited(body):
	if body is Player:
		if label != null:
			label.hide()
