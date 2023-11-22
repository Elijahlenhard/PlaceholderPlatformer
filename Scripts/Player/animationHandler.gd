class_name AnimationHandler
extends Node

@export var state: PlayerState
@export var sprite: AnimatedSprite2D
@export var tempSprite: AnimatedSprite2D
@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	tempSprite.animation_finished.connect(change_form)

#_________________________________________________________________________
#This one makes a lot of sense to turn into a finite state machine later
#Might want to move to an animation tree later know nothing about it now though |
#_________________________________________________________________________


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite.flip_h = state.direction.x < 0
	tempSprite.flip_h = state.direction.x < 0
	
	if(player.velocity.x!=0):
		sprite.animation = "walk"
	else:
		sprite.animation = "idle"
		
	tempSprite.play()
	
	
	if(Input.is_action_just_pressed("form_2")):
		state.changing_form = true
	if(state.changing_form):
		tempSprite.animation = "change_form"
	else:
		tempSprite.animation = state.form
		
	
func change_form():
	print_debug("what??")
	state.form = "ice"
	state.changing_form= false

	
