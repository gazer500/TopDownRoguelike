extends Area2D
class_name EnemyHitbox

var damage = 1


func _on_body_entered(body):
	if body is Player:
		if not body.is_inv:
			body.player_recieve_damage(damage)
		
		set_deferred("monitoring", false)
		set_deferred("monitoring", true)
