extends ProgressBar
class_name HealthBar


@onready var player : Player = get_tree().get_first_node_in_group("player")

@export var unit_size = 16


func _process(delta):
	if player != null:
		size.x = player.max_hp * unit_size
		value = (player.current_hp * 1.0) / player.max_hp * 100
