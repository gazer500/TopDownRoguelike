extends StateMachine
class_name SlimeSM

@export var chase_range := 20
@export var idle_range := 80
@onready var player : Player = get_tree().get_first_node_in_group("player")



func _ready():
	add_state("idle")
	add_state("chase")
	
	set_initial_state(states.idle)


func _state_logic(delta):
	match state:
		states.idle:
			parent.velocity = Vector2.ZERO
		states.chase:
			var angle = parent.global_position.angle_to_point(player.global_position)
			var direction = Vector2(cos(angle), sin(angle))
			parent.velocity = parent.move_speed * direction


func _get_transition(delta):
	match state:
		states.idle:
			if player.global_position.distance_to(parent.global_position) < chase_range * Global.TILE_SIZE:
				return states.chase
		states.chase:
			if player.global_position.distance_to(parent.global_position) >= idle_range * Global.TILE_SIZE:
				return states.idle
