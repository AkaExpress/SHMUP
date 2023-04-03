extends CharacterBody2D

@export var maxHealth = 100

var health = 100

func hit(damage):
	health = clampHealth(health - damage)

func clampHealth(health):
	if (health <= 0):
		die()
		return 0
	if (health >= maxHealth):
		return maxHealth
	return health

func die():
	queue_free()
