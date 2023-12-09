class_name PlayerMove
extends Node

signal hit

@export var player: CharacterBody2D
@export var player_form_change: PlayerFormChange

@export var top_speed = 450
@export var terminal_velocity = 1000

@export var jump_height = 960000
@export var jump_peak_time = 30

var slower_gravity_zone = 100.0

var lastPos = Vector2(0,0)
var g = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	g = (2*jump_height)/(pow(jump_peak_time,2))
	player.position.x+=.01


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	apply_gravity(delta)
	
	if(player.is_on_floor()):
		PlayerState.time_since_floor=0
		
		

	
#region Input for dirrectional Control
	#Checks for directional input and calls appropriate functions
	if (Input.is_action_pressed("move_right")&&!PlayerState.is_dashing):
	#&&(PlayerState.time_since_wall_jump>(PlayerState.wall_jump_time/2))|| PlayerState.wall_jump_direction == 1)):
		if(PlayerState.running_frame+delta<PlayerConst.time_to_top_speed):
			PlayerState.running_frame+=delta
		else:
			PlayerState.running_frame = PlayerConst.time_to_top_speed
		#run(delta, 1)
		PlayerState.direction.x =1 #Dash direction updated for direction character is facing
		#run(delta, PlayerState.direction.x)
		
		#player.velocity.x = top_speed
	elif (Input.is_action_pressed("move_left")&&!PlayerState.is_dashing):
	#((PlayerState.time_since_wall_jump>(PlayerState.wall_jump_time/2))|| PlayerState.wall_jump_direction == -1)):
		if(PlayerState.running_frame-delta>-PlayerConst.time_to_top_speed):
			PlayerState.running_frame-=delta
		else:
			PlayerState.running_frame = -PlayerConst.time_to_top_speed
		#run(delta, -1)
		PlayerState.direction.x =-1#Dash direction updated for direction character is facing
		#run(delta, PlayerState.direction.x)
		
		#player.velocity.x = -top_speed
	elif(!PlayerState.is_dashing && !PlayerState.is_wall_jumping):
		var new_frame = PlayerState.running_frame + -sign(player.velocity.x)*delta
		if(sign(new_frame) == sign(player.velocity.x)):
			PlayerState.running_frame = new_frame
		else:
			PlayerState.running_frame = 0
		#run(delta, 0)#if no directional input, decelerate
		#player.velocity.x = 0
		#decelerate(delta)
#endregion
	if(!PlayerState.is_wall_jumping):
		run()
		
	#Primes a jump the frame the jump key is pressed
	if Input.is_action_just_pressed("jump"):
		PlayerState.jump_primed =.1
		
	#sets jump_held to false if the jump key is released
	if (!Input.is_action_pressed("jump")):
		PlayerState.jump_held = false
	if(player.velocity.y>0):
		PlayerState.jump_held = false
	
	
		
	#if  jump is primed and the player touches the floor call the jump function
	#also checks if jump is currently held to handle holding jump key for higher jump.
	if ((PlayerState.jump_primed>0 && (player.is_on_floor() || PlayerState.time_since_floor < PlayerState.coyote_time) )):
		PlayerState.jump_held = true
		PlayerState.jump_primed =0
		PlayerState.time_since_floor = PlayerState.coyote_time
		jump(delta)
		PlayerState.is_jumping = true
	else:
		PlayerState.time_jumping = 0
		
	if(player.is_on_wall() && PersistantWorldState.unlocks["wall_jump"]):
		PlayerState.can_wall_jump = true
	
	if(PlayerState.jump_primed>0 && PlayerState.can_wall_jump && !player.is_on_floor()):
		wall_jump(delta)
		
	
	
	#if the dash key is hit and dash is off cool down call dash function
	if(Input.is_action_just_pressed("dash") && PlayerState.remaining_dash_cd<=0):
		PlayerState.is_dashing = true #disables deceleration and sets y velocity to 0 for a set time
		PlayerState.remaining_dash_cd = PlayerState.dash_cd
		
	if(PlayerState.is_dashing):
		dash(delta)
			
	if(PlayerState.remaining_dash_cd >0):
		PlayerState.remaining_dash_cd -= delta
		
	if(PlayerState.changing_form):
		player.velocity.x=0
		player.velocity.y=0
	player.move_and_slide()
	if(player.velocity.x == 0):
		player.position.x = round(player.position.x)

	
func apply_gravity(delta):
	
	var mod = 1.5
	if(PlayerState.jump_held):
		mod = 1.3
	elif(abs(player.velocity.y) <= slower_gravity_zone):
		mod = lerp(.7, 1.5, abs(player.velocity.y)/slower_gravity_zone)
	elif(!PlayerState.jump_held && player.velocity.y<0 && PlayerState.time_since_wall_jump>PlayerState.wall_jump_time):
		mod = 4
	if (!player.is_on_floor()):
		player.velocity.y += g*delta*mod
		player.velocity.y = clamp(player.velocity.y, 2*-terminal_velocity, terminal_velocity)
	"""
	var linear = 2000
	if (!player.is_on_floor()):
		player.velocity.y += (linear*delta)*((terminal_velocity-player.velocity.y)/terminal_velocity)
"""
func jump(delta):
	var linear = 55
	if(player.is_on_ceiling()):
		PlayerState.time_jumping = PlayerState.max_jump_time
	
	#if PlayerState.time_jumping < PlayerState.max_jump_time:
		#player.velocity.y -= linear*((pow(PlayerState.max_jump_time, .1)-pow(PlayerState.time_jumping,.1))/PlayerState.max_jump_time)*delta
	#	player.velocity.y -= linear/(delta+PlayerState.time_jumping)
	#	PlayerState.time_jumping += delta
	player.velocity.y -= ((2*jump_height)/jump_peak_time)*delta
	
		
		
func wall_jump(delta):
	PlayerState.is_wall_jumping = true
	PlayerState.time_since_wall_jump = 0
	player.velocity.y = 0
	var speed = Vector2(300, -750)
	player.velocity.y+=speed.y
	PlayerState.running_frame = 0
	PlayerState.wall_jump_direction = sign(player.get_wall_normal().x)
	player.velocity.x = speed.x*player.get_wall_normal().x

func run():
	player.velocity.x = MathUtil.get_speed_from_frame(PlayerState.running_frame)


func run_old(delta, direction):
	"""
	var multiplier = 1.1*direction
	var linear = 20*direction
	if(player.velocity.x<0||player.velocity.x>(top_speed+25)):
		decelerate(delta, 1)
	elif(player.velocity.x<top_speed):
		player.velocity.x = player.velocity.x*multiplier + linear
	"""
	
	var rate = 5
	var power = .5
	
	if(direction == 0 || sign(direction)!=sign(player.velocity.x)):
		rate = 5
		power = .6
	
	var wall_jump_movement_slow_time = .2
	
	if(PlayerState.time_since_wall_jump<wall_jump_movement_slow_time):
		rate = lerp(0, 5, PlayerState.time_since_wall_jump/wall_jump_movement_slow_time)
	
	var target_speed = top_speed*direction
	
	var speed_diff = target_speed - player.velocity.x
	var delta_v = pow(abs(speed_diff)*rate, power) * sign(speed_diff)

	player.velocity.x += delta_v
	
	if(direction == 0 && abs(player.velocity.x) < 5):
		player.velocity.x = 0

func decelerate_old(delta, rate):
	if(PlayerState.is_dashing):
		return
	var deceleration = .95
	if(rate == 2):
		deceleration = .9
	var linear = 20
	if(abs(player.velocity.x) < linear):
		player.velocity.x = 0
	elif(player.velocity.x > 0):
		player.velocity.x = player.velocity.x*deceleration - linear
	elif(player.velocity.x < 0):
		player.velocity.x = player.velocity.x*deceleration + linear

func dash(delta):
	#player.velocity.x = 1500*PlayerState.direction.x
	PlayerState.running_frame = .112*PlayerState.direction.x
	player.velocity.y = 0
		
	
