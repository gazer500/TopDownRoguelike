extends Node2D
class_name Weapon

enum WeaponTypes {
	WEAPON_STRAIGHT,
	WEAPON_LOBBED,
}

enum AttackTypes {
	ATTACK_MANUAL,
	ATTACK_AUTO,
}


@export var weapon_type := WeaponTypes.WEAPON_STRAIGHT
@export var attack_type := AttackTypes.ATTACK_MANUAL
@export var projectile := preload("res://scenes/straight_projectile.tscn")

@export var weapon_stats = {
	"damage": 1.0,
	"range": 6,
	"pierce": 1,
	"proj_speed": 40,
	"attack_delay": 0.5,
}


@onready var player : Player = get_tree().get_first_node_in_group("player")

var _on_cooldown := false


func _physics_process(delta):
	var fire_button_active = (
		(Input.is_action_just_pressed("left_click") and attack_type == AttackTypes.ATTACK_MANUAL)
		or (Input.is_action_pressed("left_click") and attack_type == AttackTypes.ATTACK_AUTO)
	)
	
	if fire_button_active and not _on_cooldown:
		spawn_projectile(init_projectile())
		_on_cooldown = true
		await get_tree().create_timer(weapon_stats["attack_delay"] * player.player_stats["attack_delay_mult"]).timeout
		_on_cooldown = false

func init_projectile():
	var instance = projectile.instantiate()
	instance.global_position = global_position
	var angle = global_position.angle_to_point(get_global_mouse_position())
	instance.move_direction = Vector2(cos(angle), sin(angle))
	
	var new_stats = {}
	if player != null:
		new_stats["damage"] = weapon_stats["damage"] * player.player_stats["damage_mult"]
		new_stats["range"] = weapon_stats["range"] + player.player_stats["range_mod"]
		new_stats["pierce"] = weapon_stats["pierce"] + player.player_stats["pierce_mod"]
		new_stats["proj_speed"] = weapon_stats["proj_speed"]
	
	instance.proj_stats = new_stats
	
	return instance

func spawn_projectile(instance):
	player.add_sibling(instance)
