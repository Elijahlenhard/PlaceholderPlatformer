class_name AnimationHandler
extends Node

@export var state: PlayerState
@export var sprite: AnimatedSprite2D
@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#tempSprite.animation_finished.connect(change_form)
	sprite.play()
	pass

#_________________________________________________________________________
#This one makes a lot of sense to turn into a finite state machine later
#Might want to move to an animation tree later know nothing about it now though |
#_________________________________________________________________________


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	sprite.flip_h = state.direction.x < 0
	if(state.changing_form):
		return
	if(player.velocity.x!=0):
		sprite.animation = state.form + "_run"
	else:
		sprite.animation = state.form + "_idle"
	

func _on_player_misc_input_form_changed(old_form, new_form):
	state.changing_form = true
	sprite.animation = "transform_" +old_form + "_" + new_form


func _on_animated_sprite_2d_animation_looped():
	if("transform" in sprite.animation):
		state.changing_form = false
