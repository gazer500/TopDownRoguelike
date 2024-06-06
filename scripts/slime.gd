extends Enemy
class_name Slime


@export var small_slime := preload("res://scenes/small_slime.tscn")
@export var offset := 1


func _on_death():
	for i in range(4):
		var instance = small_slime.instantiate()
		var direction = Vector2.LEFT
		
		match i:
			0:
				direction = Vector2.LEFT
			1:
				direction = Vector2.UP
			2:
				direction = Vector2.RIGHT
			3:
				direction = Vector2.DOWN
		
		instance.position = position + offset * Global.TILE_SIZE * direction
		add_sibling(instance)
	


