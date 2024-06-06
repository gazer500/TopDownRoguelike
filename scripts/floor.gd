extends Node2D
class_name Floor

@export var grid_size := 16
@export var camera : Camera2D

@onready var player : Player = get_tree().get_first_node_in_group("player") 
@onready var room_size := Vector2(get_viewport_rect().size)

var active_room := Vector2i(0, 0)
var grid : Array


func _init():
	for i in grid_size:
		grid.append([])
		for j in grid_size:
			grid[i].append(false)



func _process(delta):
	if player != null:
		active_room = Vector2(
			player.position.x as int / room_size.x as int,
			player.position.y as int / room_size.y as int
		)
		
		if player.position.x < 1:
			active_room.x -= 1
		if player.position.y < 1:
			active_room.y -= 1
		
		camera.position = active_room as Vector2 * room_size
