extends Node2D
class_name Floor

@export var grid_size := 16
@export var camera : Camera2D
@export var active_room := Vector2i(0, 0)
 
@onready var room_size := Vector2(get_viewport_rect().size)

var grid : Array
var player : Player


func _init():
	for i in grid_size:
		grid.append([])
		for j in grid_size:
			grid[i].append(false)
	
	var player_file := load("res://scenes/player.tscn")
	player = player_file.instantiate()
	add_child(player)
	
	


func _ready():
	player.position = active_room as Vector2 * room_size + Vector2(room_size.x / 2, room_size.y / 2)


func _physics_process(delta):
	active_room = Vector2(
		player.position.x as int / room_size.x as int,
		player.position.y as int / room_size.y as int
	)
	
	if player.position.x < 1:
		active_room.x -= 1
	if player.position.y < 1:
		active_room.y -= 1
		
	camera.position = active_room as Vector2 * room_size
