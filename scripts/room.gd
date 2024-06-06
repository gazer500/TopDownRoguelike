extends Node2D
class_name Room

@export var room_location := Vector2i(-1, -1)
@export var valid_room_locatiom := {
	Vector2.UP: false,
	Vector2.DOWN: false,
	Vector2.LEFT: false,
	Vector2.RIGHT: false,
}

@onready var room_size := get_viewport().get_visible_rect().size
@onready var parent_floor := get_parent()

@onready var gate := preload("res://scenes/gate.tscn")
@onready var wall := preload("res://scenes/wall.tscn")



func _ready():
	if room_location == -Vector2i.ONE:
		room_location = Vector2(
			position.x as int / room_size.x as int,
			position.y as int / room_size.y as int
		)
	
	if parent_floor is Floor:
		if room_location.x < parent_floor.grid.size() and room_location.y < parent_floor.grid[0].size():
			parent_floor.grid[room_location.x][room_location.y] = true
			
			call_deferred("_generate_gates")

func _generate_gates():
	var center = room_size / 2
	for i in valid_room_locatiom:
		var nearby_room_exists = parent_floor.grid[room_location.x + i.x][room_location.y + i.y]
		if valid_room_locatiom[i] and nearby_room_exists:
			var gate_position = center + i * Vector2(center.x - Global.TILE_SIZE * 1.5, center.y - Global.TILE_SIZE * 1.5)
			var instance = gate.instantiate()
			instance.position = gate_position
			instance.rotation = PI / 2 * i.y
			add_child(instance)
		else:
			var wall_position = center + i * Vector2(center.x - Global.TILE_SIZE * 3.5, center.y - Global.TILE_SIZE * 3.5)
			var instance = wall.instantiate()
			instance.position = wall_position
			instance.rotation = PI / 2 * i.y
			add_child(instance)
		
