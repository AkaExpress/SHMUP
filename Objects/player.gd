extends CharacterBody2D
class_name Player

const default_speed = 250.0
const default_acceleration = 1200.0
const default_friction = 0.05
const default_damage = 10.0
const default_reload_time = 0.5
const default_bullet_speed = 250.0
const default_bullet_penetration = 1
const default_resistance = 1
const bullet_path = preload("res://Objects/player_bullet.tscn")

var acceleration = default_acceleration
var friction = default_friction
var speed = default_speed
var damage = default_damage
var reload_time = default_reload_time
var bullet_speed = default_bullet_speed
var bullet_penetration = default_bullet_penetration
var resistance = default_resistance

var can_shoot = true
var invincible = false

func die():
	queue_free()

func _physics_process(delta):
	cursor_follow()
	movement(delta)
	move_and_slide()
	collisions(delta)
	if Input.is_action_pressed("shoot"):
		shoot()

func movement(delta):
	# velocity += direction * acceleration * delta
	var x_direction = Input.get_axis("move_left", "move_right") # 1, -1
	var v_direction = Input.get_axis("move_up", "move_down") # -1, 1
	if x_direction:
		velocity.x += x_direction * acceleration * delta
	else:
		velocity.x = lerp(velocity.x, 0.00, friction)
	if v_direction:
		velocity.y += v_direction * acceleration * delta
	else:
		velocity.y = lerp(velocity.y, 0.00, friction)
	velocity.x = clamp(velocity.x, -speed, speed)
	velocity.y = clamp(velocity.y, -speed, speed)

func cursor_follow():
	var target = get_global_mouse_position()
	look_at(target)
	$BulletPosition.look_at(target)

func shoot():
	if can_shoot:
		can_shoot = false
		var direction = position.direction_to(get_global_mouse_position())
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
			if collider is EnemyBullet:
				collider.queue_free()
				

