extends CharacterBody2D

const default_speed = 250.0
const default_acceleration = 800.0
const default_friction = 0.35

var acceleration = base_acceleration
var friction = base_friction
var speed = base_speed

func _physics_process(delta):
	movement(delta)
	move_and_slide()

func movement(delta):
	var x_direction = Input.get_axis("ui_left", "ui_right") # 1, -1
	var v_direction = Input.get_axis("ui_up", "ui_down") # -1, 1
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
