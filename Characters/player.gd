extends CharacterBody2D

const default_speed = 250.0
const default_acceleration = 2400.0
const default_friction = 0.05
const default_damage = 5.0
const bullet_path = preload("res://Characters/enemy.tscn")

var acceleration = default_acceleration
var friction = default_friction
var speed = default_speed
var damage = default_damage

var can_shoot = true

func die():
	queue_free()

func _physics_process(delta):
	cursor_follow()
	movement(delta)
	move_and_slide()
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

func shoot():
	if can_shoot:
		can_shoot = false
		var bullet = bullet_path.instance()
		get_parent().add_child(bullet)
		bullet.position = $Node2D.position
		await(get_tree().create_timer(0.5).timeout)
		can_shoot = true

