extends CharacterBody2D
class_name PlayerBullet

var player
var bullet_speed
var bullet_penetration
var resistance
var damage 

func _ready():
	player = Player.new()
	bullet_speed = player.bullet_speed
	bullet_penetration = player.bullet_penetration
	resistance = player.resistance
	damage = player.damage

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


