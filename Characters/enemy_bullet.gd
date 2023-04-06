extends CharacterBody2D
class_name EnemyBullet

var enemy
var bullet_speed
var damage 

func _ready():
	enemy = Enemy.new()
	bullet_speed = enemy.bullet_speed
	damage = enemy.damage

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * bullet_speed)
