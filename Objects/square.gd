extends RigidBody2D
class_name Square

var bullet_health = 1.0
var damage = 5.0

func _physics_process(delta):
	for body in get_colliding_bodies():
		if body.get("damage"):
			bullet_health -= delta * body.damage
		else:
			bullet_health -= delta * 5
	print("Square " +  str(bullet_health))
	if bullet_health <= 0:
		queue_free()

