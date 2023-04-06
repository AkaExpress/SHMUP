extends RigidBody2D
class_name EnemyBullet

var enemy
var bullet_speed
var max_bullet_health
var bullet_health
var damage 

func _ready():
	enemy = Enemy.new()
	bullet_speed = enemy.bullet_speed
	max_bullet_health = enemy.bullet_health
	bullet_health = enemy.bullet_health
	damage = enemy.damage

func _physics_process(delta):
	for body in get_colliding_bodies():
		bullet_health -= delta * body.damage
	if bullet_health <= 0:
		queue_free()

