extends CharacterBody2D
class_name PlayerBullet

var player
var bullet_speed
var max_bullet_health
var bullet_health
var damage 

var invincible = false

func _ready():
	player = Player.new()
	bullet_speed = player.bullet_speed
	max_bullet_health = player.bullet_health
	bullet_health = player.bullet_health
	damage = player.damage

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


