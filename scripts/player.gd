extends Actor
class_name Player

@export var max_hp := 6
@export var move_speed := 100
@export var inv_timer := 1

@onready var current_hp = max_hp

var is_inv := false


func _process(delta):
	if is_inv:
		$AnimatedSprite2D.modulate = Color.YELLOW
	else:
		$AnimatedSprite2D.modulate = Color.WHITE


func player_recieve_damage(damage : int = 1):
	current_hp -= damage
	if current_hp <= 0:
		queue_free()
	
	is_inv = true
	await get_tree().create_timer(inv_timer).timeout
	is_inv = false
