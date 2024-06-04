extends Actor
class_name Enemy

@export var max_hp = 5

@onready var current_hp = max_hp

func enemy_recieve_damage(damage : int = 1):
	current_hp -= damage
	if current_hp <= 0:
		queue_free()
