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
	sprite.flip_h = state.direction.x < 0
	
	if(player.velocity.x!=0):
		sprite.animation = "walk"
	else:
		sprite.animation = "idle"


	
