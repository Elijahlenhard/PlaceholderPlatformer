class_name PlayerDamage
extends Node

@export var player: CharacterBody2D

signal health_depleted(previous_health: float, new_health: float)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hitbox_body_entered(body):
	
	var enemyState = body.get_node("EnemyState")
	var vector_to_attack = body.global_position - player.global_position
	player.velocity.x+= sign(vector_to_attack.x)*100
	player.velocity.y+= 50
	

func _on_hitbox_area_entered(area):
	if(PlayerState.i_frames>0):
		return
	var enemyState = area.get_parent().get_node("EnemyState")
	var vector_to_attack = area.global_position - player.global_position
	player.velocity.x+= sign(vector_to_attack.x)*-500
	player.velocity.y-= 500
	PlayerState.i_frames = .75
	
	var new_health = PlayerState.health- enemyState.contact_damage
	
	health_depleted.emit(PlayerState.health, new_health)
	PlayerState.health = new_health
	
	if(new_health<=0):
		player.queue_free()
	
