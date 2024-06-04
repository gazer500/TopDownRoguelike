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

var _on_cooldown := false


var weapon_stats = {
	"damage": 1,
	"range": 12,
	"pierce": 2,
	"proj_speed": 40,
	"attack_delay": 0.5,
}


func _physics_process(delta):
	var fire_button_active = (
		(Input.is_action_just_pressed("left_click") and attack_type == AttackTypes.ATTACK_MANUAL)
		or (Input.is_action_pressed("left_click") and attack_type == AttackTypes.ATTACK_AUTO)
	)
	
	if fire_button_active and not _on_cooldown:
		spawn_projectile()
		_on_cooldown = true
		await get_tree().create_timer(weapon_stats["attack_delay"]).timeout
		_on_cooldown = false


func spawn_projectile():
	var instance = projectile.instantiate()
	instance.global_position = global_position
	instance.proj_stats = weapon_stats
	get_parent().get_parent().add_child(instance)
