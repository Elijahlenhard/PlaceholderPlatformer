class_name EnemyDamage
extends Node

@export var enemy: CharacterBody2D
@export var state: EnemyState
@export var sounds: EnemySounds
@export var collision: CollisionShape2D
@export var hitBox: CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(attack):
	var attack_script = attack.get_node("Attack")
	var damage = attack_script.damage
	var direction = attack_script.direction
	var knock_back = attack_script.knock_back
	
	var vector_to_attack = attack.global_position - enemy.global_position
	
	state.health -= damage
	if(state.health<= 0):
		state.dying = true
		

	sounds.play_hit_sound()
	
	enemy.velocity.y = knock_back.y
	enemy.velocity.x = sign(direction)*knock_back.x


