extends CharacterBody2D

@export var speed = 125.0
@export var acceleration = 2400.0
@export var friction = 0.05

func _physics_process(delta):
	follow_player(delta)
	move_and_slide()

func follow_player(delta):
	var target = get_parent().get_node("Player").position
	look_at(target)
	if position.distance_to(target) > 300:
		velocity += position.direction_to(target) * acceleration * delta
	else:
		velocity.x = lerp(velocity.x, 0.00, friction)
		velocity.y = lerp(velocity.y, 0.00, friction)
	
	velocity.x = clamp(velocity.x, -speed, speed)
	velocity.y = clamp(velocity.y, -speed, speed)

func die():
	queue_free()
