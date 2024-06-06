extends Area2D
class_name WeaponPickup


@export var weapon : PackedScene = load("res://scenes/pistol.tscn")

func _on_body_entered(body):
	var instance = weapon.instantiate()
	
	if body is Player and instance is Weapon:
		for i in body.get_children():
			if i is Weapon:
				i.queue_free()
		
		body.add_child(instance)
		queue_free()
