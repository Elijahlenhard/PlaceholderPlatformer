class_name PlayerMove
extends Node

signal hit

@export var player: CharacterBody2D
@export var animatedSprite: AnimatedSprite2D
@export var state: PlayerState

@export var top_speed = 250
@export var terminal_velocity = 2000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	apply_gravity(delta)
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
		state.jump_primed =3#if the player touches the ground at anypoint in the next 3 frames, execute a jump
		
	#sets jump_held to false if the jump key is released
	if !Input.is_action_pressed("jump"):
		state.jump_held = false
	
	if state.jump_primed>0:#if a jump is primed
		state.jump_primed -=1#decrement jump primed var
		
	#if I jump is primed and the player touches the floor call the jump function
	#also checks if jump is currently held to handle holding jump key for higher jump.
	if ((state.jump_primed>0 && player.is_on_floor()) || state.jump_held):
		state.jump_held = true
		jump(delta)
	else:
		state.time_jumping = 0
	
	#if the dash key is hit and dash is off cool down call dash function
	if(Input.is_action_just_pressed("dash") && state.remaining_dash_cd<=0):
		state.is_dashing = true #disables deceleration and sets y velocity to 0 for a set time
		dash(delta)
		state.remaining_dash_cd = state.dash_cd
		
	if(state.is_dashing):
		state.dash_time += delta
		if (state.dash_time > .15):
			state.is_dashing = false
			state.dash_time =0
		player.velocity.y =0
			
	if(state.remaining_dash_cd >0):
		state.remaining_dash_cd -= delta

	if player.velocity.length() > 0:
		animatedSprite.play()
		
	player.move_and_slide()
	

	
func apply_gravity(delta):
	var linear = 1200
	if (!player.is_on_floor()):
		player.velocity.y += (linear*delta)*((terminal_velocity-player.velocity.y)/terminal_velocity)

func jump(delta):
	var linear = 7000
	if(player.is_on_ceiling()):
		state.time_jumping = state.max_jump_time
	if state.time_jumping < state.max_jump_time:
		player.velocity.y -= linear*((pow(state.max_jump_time, .1)-pow(state.time_jumping,.1))/state.max_jump_time)*delta
		state.time_jumping += delta

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
	player.velocity.x = 1000*state.direction.x
		
	
