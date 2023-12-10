extends Node
@export var terminal_velocity = 1000


func apply_gravity(enemy: CharacterBody2D, g:float, delta:float):
	if (!enemy.is_on_floor()):
		enemy.velocity.y += g*delta
		enemy.velocity.y = clamp(enemy.velocity.y, 2*-terminal_velocity, terminal_velocity)
