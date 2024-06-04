extends Node

const TILE_SIZE = 8

var move_input := Vector2.ZERO

func _process(delta):
	move_input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
