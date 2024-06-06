extends Weapon
class_name Shotgun


@export var projectile_count := 5
@export var projectile_spread := 45.0


func spawn_projectile(instance):
	for i in projectile_count:
		instance = init_projectile()
		var angle = global_position.angle_to_point(get_global_mouse_position()) - deg_to_rad(projectile_spread / 2) + deg_to_rad(projectile_spread / projectile_count * 2) * i
		instance.move_direction = Vector2(cos(angle), sin(angle))
		super.spawn_projectile(instance)
