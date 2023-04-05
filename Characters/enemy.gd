extends CharacterBody2D

const default_speed = 100.0
const default_acceleration = 800.0
const default_friction = 0.05
const default_damage = 5.0
const default_bullet_speed = 300.0
const bullet_path = preload("res://Characters/enemy_bullet.tscn")

var acceleration = default_acceleration
var friction = default_friction
var speed = default_speed
var damage = default_damage
var bullet_speed = default_bullet_speed

var forced_aggro = false
var aggro = false

func _physics_process(delta):
	aggro_checks()
	follow_player(delta)
	move_and_slide()

func aggro_checks():
	var player = get_parent().get_node("Player")
	if !aggro:
		if $RayCast2D.is_colliding() and $RayCast2D.get_collider() == player:
			aggro = true
			forced_aggro = false
		if position.distance_to(player.position) < 450:
			aggro = true
			forced_aggro = false
	elif !forced_aggro:
		if position.distance_to(player.position) > 650:
			aggro = false
	else:
		if position.distance_to(player.position) > 1750:
			forced_aggro = false


func follow_player(delta):
	var target = get_parent().get_node("Player").position
	if aggro:
		look_at(target)
	if position.distance_to(target) > 300 and aggro:
		velocity += position.direction_to(target) * acceleration * delta
	else:
		velocity.x = lerp(velocity.x, 0.00, friction)
		velocity.y = lerp(velocity.y, 0.00, friction)
	
	velocity.x = clamp(velocity.x, -speed, speed)
	velocity.y = clamp(velocity.y, -speed, speed)

func _on_bullet_entered(body):
	if !body is PlayerBullet:
		return
	$HealthManager.hit(body.damage)
	aggro = true
	forced_aggro = true
	body.queue_free()

func die():
	queue_free()
