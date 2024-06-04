extends Actor
class_name Player

@export var max_hp := 6
@export var inv_timer := 1
var player_stats = {
	"damage_mult": 1.5,
	"range_mod": 10,
	"pierce_mod": 1,
	"attack_delay_mult": 0.8,
}

@onready var current_hp = max_hp

var is_inv := false


func _process(delta):
	if is_inv:
		modulate = Color.YELLOW
	else:
		modulate = Color.WHITE


func player_recieve_damage(damage : int = 1):
	current_hp -= damage
	
	is_inv = true
	await get_tree().create_timer(inv_timer).timeout
	is_inv = false
