class_name PlayerMove
extends Node

signal hit

@export var player: CharacterBody2D
@export var state: PlayerState

@export var top_speed = 550
@export var terminal_velocity = 1000

@export var jump_height = 960000
@export var jump_peak_time = 30

var slower_gravity_zone = 200.0


var lastPos = Vector2(0,0)
var g = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	g = (2*jump_height)/(pow(jump_peak_time,2))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	print_debug(player.velocity)
	lastPos= player.position
	apply_gravity(delta)
	
	if(player.is_on_floor()):
		state.time_since_floor=0
	
	#Checks for directional input and calls appropriate functions
	if Input.is_action_pressed("move_right"):
		run_right(delta)
		state.direction.x =1 #Dash direction updated for direction character is facing
	elif Input.is_action_pressed("move_left"):
		run_left(delta)
		state.direction.x =-1#Dash direction updated for direction character is facing
	else:
		decelerate(delta, 1)#if no directional input, decelerate
		
	#Primes a jump the frame the jump key is pressed
	if Input.is_action_just_pressed("jump"):
		state.jump_primed =.1#if the player touches the ground at anypoint in the next 3 frames, execute a jump
		
	#sets jump_held to false if the jump key is released
	if (!Input.is_action_pressed("jump")):
		state.jump_held = false
	if(player.velocity.y>0):
		state.jump_held = false
		state.is_wall_jumping = false
	
	
		
	#if  jump is primed and the player touches the floor call the jump function
	#also checks if jump is currently held to handle holding jump key for higher jump.
	if ((state.jump_primed>0 && (player.is_on_floor() || state.time_since_floor < state.coyote_time) )):
		state.jump_held = true
		state.jump_primed =0
		state.time_since_floor = state.coyote_time
		jump(delta)
	else:
		state.time_jumping = 0
		
	if(player.is_on_wall()):
		state.can_wall_jump = true
	
	if(state.jump_primed>0 && state.can_wall_jump && !player.is_on_floor()):
		wall_jump(delta)
	
	
	#if the dash key is hit and dash is off cool down call dash function
	if(Input.is_action_just_pressed("dash") && state.remaining_dash_cd<=0):
		state.is_dashing = true #disables deceleration and sets y velocity to 0 for a set time
		dash(delta)
		state.remaining_dash_cd = state.dash_cd
		
	if(state.is_dashing):
		state.dash_time += delta
		if (state.dash_time > .1):
			state.is_dashing = false
			state.dash_time =0
		player.velocity.y =0
			
	if(state.remaining_dash_cd >0):
		state.remaining_dash_cd -= delta
		
	if(state.changing_form):
		player.velocity.x=0
		player.velocity.y=0
	player.move_and_slide()


	
func apply_gravity(delta):
	
	var mod = 1.5
	if(state.jump_held):
		mod = 1.3
	elif(abs(player.velocity.y) <= slower_gravity_zone):
		lerp(.7, 3.0, abs(player.velocity.y)/slower_gravity_zone)
	elif(!state.jump_held && player.velocity.y<0 && !state.is_wall_jumping):
		mod = 3
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
		state.time_jumping = state.max_jump_time
	
	#if state.time_jumping < state.max_jump_time:
		#player.velocity.y -= linear*((pow(state.max_jump_time, .1)-pow(state.time_jumping,.1))/state.max_jump_time)*delta
	#	player.velocity.y -= linear/(delta+state.time_jumping)
	#	state.time_jumping += delta
	player.velocity.y -= ((2*jump_height)/jump_peak_time)*delta
	print_debug(player.velocity)
	
		
		
func wall_jump(delta):
	state.is_wall_jumping = true
	player.velocity.y = 0
	var speed = Vector2(500, -1050)
	player.velocity.y+=speed.y
	
	player.velocity.x = speed.x*player.get_wall_normal().x

func run_right(delta):
	var multiplier = 1.1
	var linear = 20
	if(player.velocity.x<0||player.velocity.x>(top_speed+25)):
		decelerate(delta, 2)
	elif(player.velocity.x<top_speed):
		player.velocity.x = player.velocity.x*multiplier + linear
		
func run_left(delta):
	var multiplier = 1.1
	var linear = -20
	if(player.velocity.x>0 ||player.velocity.x<-(top_speed+25)):
		decelerate(delta, 2)
	elif(player.velocity.x>-top_speed):
		player.velocity.x = player.velocity.x*multiplier + linear

func decelerate(delta, rate):
	if(state.is_dashing):
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
	player.velocity.x = 1500*state.direction.x
		
	
