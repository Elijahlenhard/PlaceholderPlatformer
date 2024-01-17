class_name IceWalkerController
extends Node

@export var enemy: CharacterBody2D
@export var g: float
@export var move_speed: float
@export var state: EnemyState
@export var attack_trigger_range: int
@export var agro_range: int

var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent().get_node("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var vector_to_player = player.position - enemy.position
	if(vector_to_player.length() < agro_range):
		state.sees_player = true
	else:
		state.sees_player = false
	
	if(state.sees_player):
		walk(sign(vector_to_player.x))
		if(state.run_direction!= sign(vector_to_player.x)):
			state.run_direction = sign(vector_to_player.x)
			get_parent().scale.x = -1
		
	if(state.attack_cd < state.attack_max_cd):
		state.attack_cd += delta
	if(vector_to_player.length() < attack_trigger_range && state.attack_cd>= state.attack_max_cd):
		state.attacking = true
		state.attack_cd = 0
	
	EnemyHelper.apply_gravity(enemy, g, delta)
	enemy.move_and_slide()

	
func walk(direction: int):
	enemy.velocity.x = lerp(enemy.velocity.x, move_speed*sign(direction), .05)
