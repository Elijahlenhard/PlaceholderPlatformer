class_name AnimationHandler
extends Node

@export var state: PlayerState
@export var sprite: AnimatedSprite2D
@export var player: CharacterBody2D

var time = 0

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


	if(state.is_dashing):
		sprite.modulate = Color(1,1,1.5,1)
	else:
		sprite.modulate = Color(1,1,1,1)

	sprite.flip_h = state.direction.x < 0
	if(state.changing_form):
		return
	if(player.velocity.x!=0):
		sprite.animation = state.form + "_run"
	else:
		sprite.animation = state.form + "_idle"
		
	
	var jump_frame = -1
	
	if(player.velocity.y>0):
		jump_frame = lerp(5.5, 10.0, player.velocity.y/1000)
		jump_frame = round(jump_frame)
	elif(player.velocity.y<0):
		jump_frame = lerp(6, 0, player.velocity.y/-1066)
	if(jump_frame!=-1):
		sprite.animation = "jump"
		sprite.frame = jump_frame
		var string_format = "(%f,%f)"
	
	time += delta
func _on_player_misc_input_form_changed(old_form, new_form):
	state.changing_form = true
	sprite.animation = "transform_" +old_form + "_" + new_form


func _on_animated_sprite_2d_animation_looped():
	if("transform" in sprite.animation):
		state.changing_form = false
