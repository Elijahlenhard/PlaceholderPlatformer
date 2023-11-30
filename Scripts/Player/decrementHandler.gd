class_name DecrementHandler
extends Node

@export var state: PlayerState

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	await(!state.form_change_ui_open)
	if state.jump_primed>0:#if a jump is primed
		state.jump_primed -=delta#decrement jump primed var
		
	if(state.can_wall_jump == true && state.time_since_wall <= .1):
		state.time_since_wall+=delta
		
	if(state.can_wall_jump && state.time_since_wall >= .1):
		state.can_wall_jump = false
		state.time_since_wall = 0
		
	if(state.time_since_wall_jump<=state.wall_jump_time):
		state.time_since_wall_jump +=delta
	else:
		state.is_wall_jumping = false
	
	if(state.is_dashing):
		state.dash_time += delta
		if (state.dash_time > state.dash_length):
			state.is_dashing = false
			state.dash_time =0
	
	
	
	if(state.attack_cd>0):
		state.attack_cd-=delta	
		
	if(state.i_frames>0):
		state.i_frames-=delta
		
	if(state.fire_wave_cd>0):
		state.fire_wave_cd-=delta
		
	if(state.ice_slam_cd>0):
		state.ice_slam_cd-=delta
		
	if(state.time_since_basic<2):
		state.time_since_basic+=delta	
	else:
		state.attack_variation=1
		
	if(state.time_since_floor < state.coyote_time):
		state.time_since_floor += delta
	
