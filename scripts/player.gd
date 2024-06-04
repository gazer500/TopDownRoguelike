extends Actor
class_name Player

@export var max_hp := 6
@export var move_speed := 300
@export var inv_timer := 1

@onready var current_hp = max_hp

var is_inv := false


func _process(delta):
	if is_inv:
		$Icon.modulate = Color.YELLOW
	else:
		$Icon.modulate = Color.WHITE



func player_recieve_damage(damage : int = 1):
	current_hp -= damage
	if current_hp <= 0:
		queue_free()
	
	is_inv = true
	await get_tree().create_timer(inv_timer).timeout
	is_inv = false
