extends CharacterBody2D

@export var speed = 500.0

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
