class_name EnemyAnimations
extends Node

@export var state: EnemyState
@export var animation: AnimatedSprite2D
@export var enemy: CharacterBody2D
@export var attacks: Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(animation == null):
		return
	if(state.dying):
		animation.animation = "death"
		animation.play()
	elif(state.attacking == true):
		animation.animation = "attack"
		if(animation.frame == 7):
			attacks.get_node("Basic").disabled=false
		else:
			attacks.get_node("Basic").disabled=true
		animation.play()
	else:
		animation.animation = "default"

func _on_animated_sprite_2d_animation_finished():
	if(animation.animation == "death"):
		enemy.queue_free()
	if(animation.animation == "attack"):
		state.attacking = false
