extends Node

@export var maxHealth = 100

var health = 100

func hit(damage):
	health = clampHealth(health - damage)
	print("Health is " + str(health))

func clampHealth(health):
	if (health <= 0):
		get_parent().die()
		return 0
	if (health >= maxHealth):
		return maxHealth
	return health
