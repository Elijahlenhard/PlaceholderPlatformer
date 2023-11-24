class_name PlayerMiscInput
extends Node

@export var state: PlayerState
signal form_changed(old_form, new_form)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("fire_form")):
		if(state.form=="fire"):
			return
		form_changed.emit(state.form, "fire")
		state.form = "fire"
		
	if(Input.is_action_just_pressed("ice_form")):
		if(state.form=="ice"):
			return
		form_changed.emit(state.form, "ice")
		state.form = "ice"
