extends CharacterBody2D
class_name Projectile


var proj_stats = {
	"damage": 10,
	"range": 1,
	"pierce": 2,
	"proj_speed": 800,
	"attack_delay": 0.5,
	}

var move_direction := Vector2.ZERO

@onready var _initial_position := position


func _ready():
	var angle = global_position.angle_to_point(get_global_mouse_position())
	move_direction = Vector2(cos(angle), sin(angle))
	velocity = move_direction * proj_stats["proj_speed"]


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if _initial_position.distance_to(position) > proj_stats["range"] * Global.TILE_SIZE:
		queue_free()
	
	if is_instance_valid(collision):
		var collider = collision.get_collider()
		queue_free()
