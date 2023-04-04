extends CharacterBody2D
class_name PlayerBullet

var player
var bullet_speed
var damage 

func _ready():
	player = Player.new()
	bullet_speed = player.bullet_speed
	damage = player.damage

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * bullet_speed)
