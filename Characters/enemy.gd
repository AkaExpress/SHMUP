extends CharacterBody2D

@export var speed = 250

func _physics_process(delta):
	follow_player(delta)

func follow_player(delta):
	var target = get_parent().get_node("Player").position
	look_at(target)
	velocity += position.direction_to(target) * speed * delta
	
	velocity.x = clamp(velocity.x, -speed, speed)
	velocity.y = clamp(velocity.y, -speed, speed)
	
	if position.distance_to(target) > 10:
		move_and_slide()

func die():
	queue_free()
