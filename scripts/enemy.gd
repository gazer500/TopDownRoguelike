extends Actor
class_name Enemy

@export var max_hp := 5.0

@onready var current_hp := max_hp
@onready var player : Player = get_tree().get_first_node_in_group("player") 
@onready var death_effect := preload("res://scenes/death_effect.tscn")


func _ready():
	modulate = Color.RED


func enemy_recieve_damage(damage = 1):
	current_hp -= damage
	
	if current_hp <= 0:
		var instance = death_effect.instantiate()
		instance.global_position = global_position
		add_sibling(instance)
		
		call_deferred("_on_death")
		call_deferred("queue_free")
	
	modulate = Color.YELLOW
	await get_tree().create_timer(0.3).timeout
	modulate = Color.RED


func _on_death():
	pass
