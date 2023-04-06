extends CharacterBody2D
class_name EnemyBullet

var enemy
var bullet_speed
var max_bullet_health
var bullet_health
var damage 

var invincible = false

func _ready():
	enemy = Enemy.new()
	bullet_speed = enemy.bullet_speed
	max_bullet_health = enemy.bullet_health
	bullet_health = enemy.bullet_health
	damage = enemy.damage

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * bullet_speed)

func _on_bullet_entered(body):
	if body == self:
		return
	if !invincible:
		invincible = true
		await(get_tree().create_timer(0.1).timeout)
		queue_free()
		invincible = false


