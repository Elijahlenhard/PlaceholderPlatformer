class_name EnemyMove
extends Node

@export var enemy: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!enemy.is_on_floor()):
		enemy.velocity.y+=100
	else:
		enemy.velocity.y=0
		
	enemy.move_and_slide()
