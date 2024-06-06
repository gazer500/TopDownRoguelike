extends AnimatedSprite2D
class_name DeathEffect


func _ready():
	play("default")


func _on_animation_finished():
	queue_free()
