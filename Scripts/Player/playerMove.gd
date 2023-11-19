extends CharacterBody2D

signal hit

@export var top_speed = 200
var screen_size
var time_jumping =0
var max_jump_time = .66
@export var terminal_velocity = 2000
@export var g = 1
var jump_primed = -1
var jump_held
var dash_direction = Vector2(0,1)
var dash_time = 0
var is_dashing = false
var dash_cd = 1.5
var remaining_dash_cd = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#saveManager = get_tree().current_scene.get_node("SaveManager") Example for later


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	apply_gravity(delta)
	
	if Input.is_action_pressed("move_right"):
		run_right(delta)
		dash_direction.x =1
	elif Input.is_action_pressed("move_left"):
		run_left(delta)
		dash_direction.x =-1
	else:
		decelerate(delta, 1)
		
		
	if Input.is_action_pressed("jump"):
		jump_primed = 3
	else:
		jump_held = false
	if jump_primed>0:
		jump_primed -=1
	if ((jump_primed>0 && is_on_floor()) || jump_held):
		jump_held = true
		jump(delta)
	else:
		time_jumping = 0
		
	if(Input.is_action_just_pressed("dash") && remaining_dash_cd<=0):
		is_dashing = true
		dash(delta)
		remaining_dash_cd = dash_cd
	if(is_dashing):
		dash_time += delta
		if (dash_time > .15):
			is_dashing = false
			dash_time =0
			
	if(remaining_dash_cd >0):
		remaining_dash_cd -= delta

	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	move_and_slide()
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0

	print_debug(velocity)
	
	

func apply_gravity(delta):
	var linear = 1200
	if !is_on_floor():
		velocity.y += (linear*delta)*((terminal_velocity-velocity.y)/terminal_velocity)
	

func jump(delta):
	var linear = 7000
	if(is_on_ceiling()):
		time_jumping = max_jump_time
	if time_jumping < max_jump_time:
		velocity.y -= linear*((pow(max_jump_time, .1)-pow(time_jumping,.1))/max_jump_time)*delta
		time_jumping += delta

func run_right(delta):
	var acceleration = 1.1
	var linear = 20
	if(velocity.x<0||velocity.x>(top_speed+25)):
		decelerate(delta, 1)
	elif(velocity.x<top_speed):
		velocity.x = velocity.x*acceleration + linear
		
func run_left(delta):
	var acceleration = 1.1
	var linear = -20
	if(velocity.x>0 ||velocity.x<-(top_speed+25)):
		decelerate(delta, 1)
	elif(velocity.x>-top_speed):
		velocity.x = velocity.x*acceleration + linear

func decelerate(delta, rate):
	if(is_dashing):
		print_debug("isDashing")
		return
	var deceleration = .9
	var linear = 20
	if(abs(velocity.x) < linear):
		velocity.x = 0
	elif(velocity.x > 0):
		velocity.x = velocity.x*deceleration - linear
	elif(velocity.x < 0):
		velocity.x = velocity.x*deceleration + linear

func dash(delta):
	velocity.x = 1000*dash_direction.x
		
	


"""func _on_body_entered(body):
	hide()
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	"""
