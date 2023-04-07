extends CharacterBody2D
class_name EnemyBullet

var enemy
var bullet_speed
var bullet_penetration
var resistance
var damage 

func _ready():
	enemy = Enemy.new()
	bullet_speed = enemy.bullet_speed
	bullet_penetration = enemy.bullet_penetration
	resistance = enemy.resistance
	damage = enemy.damage

func _physics_process(delta):
	var motion = move_and_collide(velocity.normalized() * delta * bullet_speed)
	if motion:
		if motion.get_collider():
			var collider = motion.get_collider()
			if collider.get("resistance"):
				if bullet_penetration < collider.resistance:
					velocity = velocity.bounce(motion.get_normal())
			else:
				velocity = velocity.bounce(motion.get_normal())


