extends CharacterBody2D
class_name Enemy

const default_speed = 100.0
const default_acceleration = 800.0
const default_friction = 0.05
const default_damage = 5.0
const default_reload_time = 0.75
const default_bullet_speed = 150.0
const default_bullet_penetration = 1
const default_resistance = 1
const bullet_path = preload("res://Objects/enemy_bullet.tscn")

var acceleration = default_acceleration
var friction = default_friction
var speed = default_speed
var damage = default_damage
var reload_time = default_reload_time
var bullet_speed = default_bullet_speed
var bullet_penetration = default_bullet_penetration
var resistance = default_resistance

var can_shoot = true
var forced_aggro = false
var aggro = false
var invincible = false

func _physics_process(delta):
	aggro_checks()
	follow_player(delta)
	move_and_slide()
	collisions(delta)

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
		shoot()
		look_at(target)
	if position.distance_to(target) > 300 and aggro:
		velocity += position.direction_to(target) * acceleration * delta
	else:
		velocity.x = lerp(velocity.x, 0.00, friction)
		velocity.y = lerp(velocity.y, 0.00, friction)
	
	velocity.x = clamp(velocity.x, -speed, speed)
	velocity.y = clamp(velocity.y, -speed, speed)

func shoot():
	if can_shoot:
		can_shoot = false
		var direction = position.direction_to($BulletPosition.global_position)
		var bullet = bullet_path.instantiate()
		get_parent().add_child(bullet)
		bullet.position = $BulletPosition.global_position
		bullet.velocity = direction
		await(get_tree().create_timer(reload_time).timeout)
		can_shoot = true

func collisions(delta):
	if !invincible:
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			if collider.get("damage"):
				$HealthManager.hit(collider.damage)
			else:
				$HealthManager.hit(5)
			if collider is PlayerBullet:
				collider.queue_free()
				

func die():
	queue_free()
