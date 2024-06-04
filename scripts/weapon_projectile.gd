extends Area2D
class_name Projectile


var proj_stats = {
	"damage": 1,
	"range": 1,
	"pierce": 1,
	"proj_speed": 1,
	"attack_delay": 1,
	}

var move_direction := Vector2.ZERO
var velocity := Vector2.ZERO

@onready var _initial_position := position
@onready var _remaining_pierce : int = proj_stats["pierce"]


func _ready():
	var angle = global_position.angle_to_point(get_global_mouse_position())
	move_direction = Vector2(cos(angle), sin(angle))
	velocity = move_direction * proj_stats["proj_speed"] * Global.TILE_SIZE


func _physics_process(delta):
	position += velocity * delta
	
	if _initial_position.distance_to(position) > proj_stats["range"] * Global.TILE_SIZE:
		queue_free()
	


func _on_body_entered(body):
	if body is Enemy:
		_remaining_pierce -= 1
		if _remaining_pierce <= 0:
			queue_free()
		
		body.enemy_recieve_damage(proj_stats["damage"])
	else:
		queue_free()
