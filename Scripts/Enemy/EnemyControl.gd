class_name EnemyControl
extends Node

@export var enemy: CharacterBody2D
@export var state: EnemyState
@export var move: EnemyMove

# Called when the node enters the scene tree for the first time.
func _ready():
	state.run_direction = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(enemy.is_on_wall()):
		state.run_direction = enemy.get_wall_normal().x
	
	if(state.run_direction >0):
		move.run_right(delta)
	if(state.run_direction <0):
		move.run_left(delta)
	
