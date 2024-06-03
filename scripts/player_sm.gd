extends StateMachine
class_name PlayerSM

var player : Player

func _ready():
	add_state("idle")
	add_state("walk")
	
	set_initial_state(states.idle)
	
	player = parent


func _state_logic(delta):
	match state:
		states.idle:
			player.velocity = Vector2.ZERO
		states.walk:
			player.velocity = player.move_speed * Global.move_input.normalized()



func _get_transition(delta):
	match state:
		states.idle:
			if Global.move_input != Vector2.ZERO:
				return states.walk
		states.walk:
			if Global.move_input == Vector2.ZERO:
				return states.idle
