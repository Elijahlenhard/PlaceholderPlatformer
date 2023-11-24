class_name EnemyAnimations
extends Node

@export var state: EnemyState
@export var animation: AnimatedSprite2D
@export var enemy: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animation.flip_h = state.run_direction>0
	if(state.dying):
		animation.animation = "death"
	else:
		animation.animation = "default"

func _on_animated_sprite_2d_animation_finished():
	if(animation.animation == "death"):
		enemy.queue_free()
