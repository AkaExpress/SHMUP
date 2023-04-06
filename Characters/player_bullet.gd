extends CharacterBody2D
class_name PlayerBullet

var player
var bullet_speed
var max_bullet_health
var bullet_health
var damage 

var colliders = []

func _ready():
	player = Player.new()
	bullet_speed = player.bullet_speed
	max_bullet_health = player.bullet_health
	bullet_health = player.bullet_health
	damage = player.damage

func _physics_process(delta):
	for body in colliders:
		if !body:
			continue
		if body.get("damage"):
			bullet_health -= delta * body.damage
		else:
			bullet_health -= delta * 5
	if bullet_health <= 0:
		queue_free()
	move_and_collide(velocity.normalized() * delta * bullet_speed)

func _on_body_entered(body):
	if body == self or body is PlayerBullet:
		return
	colliders.append(body)

func _on_body_exited(body):
	if body == self or body is PlayerBullet:
		return
	var index = colliders.find(body)
	if index >= 0:
		colliders.remove_at(index)
