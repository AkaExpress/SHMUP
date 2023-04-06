extends RigidBody2D
class_name PlayerBullet

var player
var bullet_speed
var max_bullet_health
var bullet_health
var damage 

func _ready():
	player = Player.new()
	bullet_speed = player.bullet_speed
	max_bullet_health = player.bullet_health
	bullet_health = player.bullet_health
	damage = player.damage

func _physics_process(delta):
	for body in get_colliding_bodies():
		if body.get("damage"):
			bullet_health -= delta * body.damage
		else:
			bullet_health -= delta * 5
	if bullet_health <= 0:
		queue_free()
