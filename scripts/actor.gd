extends CharacterBody2D
class_name Actor

@export var move_speed := 150


func _physics_process(delta):
	move_and_slide()
