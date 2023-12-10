class_name DecrementHandler
extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerState.jump_primed>0:#if a jump is primed
		PlayerState.jump_primed -=delta#decrement jump primed var
		
	if(PlayerState.can_wall_jump == true && PlayerState.time_since_wall <= .1):
		PlayerState.time_since_wall+=delta
		
	if(PlayerState.can_wall_jump && PlayerState.time_since_wall >= .1):
		PlayerState.can_wall_jump = false
		PlayerState.time_since_wall = 0
		
	if(PlayerState.time_since_wall_jump<=PlayerState.wall_jump_time):
		PlayerState.time_since_wall_jump +=delta
	else:
		PlayerState.is_wall_jumping = false
	
	if(PlayerState.is_dashing):
		PlayerState.dash_time += delta
		if (PlayerState.dash_time > PlayerState.dash_length):
			PlayerState.is_dashing = false
			PlayerState.dash_time =0
	
	if(PlayerState.ability_resource<2):
		PlayerState.ability_resource_charge +=delta
		if(PlayerState.ability_resource_charge >=PlayerState.seconds_per_resource):
			PlayerState.ability_resource+= 1
			PlayerState.ability_resource_charge=0
			
	else:
		PlayerState.ability_resource_charge = 0
	
	if(PlayerState.form_change_cd>0):
		PlayerState.form_change_cd-=delta
	
	if(PlayerState.attack_cd>0):
		PlayerState.attack_cd-=delta	
		
	if(PlayerState.i_frames>0):
		PlayerState.i_frames-=delta
		
	if(PlayerState.fire_wave_cd>0):
		PlayerState.fire_wave_cd-=delta
		
	if(PlayerState.ice_slam_cd>0):
		PlayerState.ice_slam_cd-=delta
		
	if(PlayerState.time_since_basic<2):
		PlayerState.time_since_basic+=delta	
	else:
		PlayerState.attack_variation=1
		
	if(PlayerState.time_since_floor < PlayerState.coyote_time):
		PlayerState.time_since_floor += delta
		
	
	
