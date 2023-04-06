extends CharacterBody2D
class_name EnemyBullet

var enemy
var bullet_speed
var max_bullet_health
var bullet_health
var damage 

var colliders = []

func _ready():
	enemy = Enemy.new()
	bullet_speed = enemy.bullet_speed
	max_bullet_health = enemy.bullet_health
	bullet_health = enemy.bullet_health
	damage = enemy.damage

func _physics_process(delta):
	for body in colliders:
		if body.get("damage"):
			bullet_health -= delta * body.damage
		else:
			bullet_health -= delta * 5
	if bullet_health <= 0:
		queue_free()
		colliders.clear()
	move_and_collide(velocity.normalized() * delta * bullet_speed)

func _on_body_entered(body):
	if body == self or body is EnemyBullet:
		return
	colliders.append(body)

func _on_body_exited(body):
	if body == self or body is EnemyBullet:
		return
	var index = colliders.find(body)
	if index >= 0:
		colliders.remove_at(index)
