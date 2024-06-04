extends StateMachine
class_name PlayerSM

var player : Player

func _ready():
	add_state("idle")
	add_state("walk")
	add_state("dead")
	
	set_initial_state(states.idle)
	
	player = parent


func _state_logic(delta):
	match state:
		states.idle:
			player.velocity = Vector2.ZERO
		states.walk:
			player.velocity = player.move_speed * Global.move_input.normalized()
			
			if player.velocity.x > 0:
				player.get_node("AnimatedSprite2D").flip_h = false
			if player.velocity.x < 0:
				player.get_node("AnimatedSprite2D").flip_h = true
		states.dead:
			player.velocity = Vector2.ZERO
			player.hide()



func _get_transition(delta):
	match state:
		states.idle:
			if player.current_hp <= 0:
				return states.dead
				
			if Global.move_input != Vector2.ZERO:
				return states.walk
		states.walk:
			if player.current_hp <= 0:
				return states.dead
				
			if Global.move_input == Vector2.ZERO:
				return states.idle


func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			player.get_node("AnimatedSprite2D").play("idle")
		states.walk:
			player.get_node("AnimatedSprite2D").play("walk")
		states.dead:
			player.get_node("AnimatedSprite2D").play("death")


func _on_animation_finished():
	if player.get_node("AnimatedSprite2D").get_animation() == "death":
		player.hide()
