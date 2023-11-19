extends CharacterBody2D

signal hit

@export var top_speed = 200
var screen_size
var time_jumping =0
@export var terminal_velocity = 500
@export var g = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	_apply_gravity(delta)
	
	if Input.is_action_pressed("move_right"):
		_accelerate_right(delta)

	elif Input.is_action_pressed("move_left"):
		_accelerate_left(delta)
	else:
		_decelerate(delta, 1)
		
		
	if Input.is_action_pressed("Jump"):
		_jump(delta)
	else:
		time_jumping = 0

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
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "jump"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
	print_debug(velocity)
	

func _apply_gravity(delta):
	var linear = 600
	if !is_on_floor():
		velocity.y += linear*delta
	

func _jump(delta):
	var acceleration = 1.1
	var linear = 1200
	var max_jump_time = .66
	if time_jumping < max_jump_time:
		velocity.y -= linear*((max_jump_time-time_jumping)/max_jump_time)*delta
		time_jumping += delta

func _accelerate_right(delta):
	var acceleration = 1.1
	var linear = 20
	if(velocity.x<0):
		_decelerate(delta, 1)
	elif(velocity.x<top_speed):
		velocity.x = velocity.x*acceleration + linear
		
func _accelerate_left(delta):
	var acceleration = 1.1
	var linear = -20
	if(velocity.x>0):
		_decelerate(delta, 1)
	elif(velocity.x>-top_speed):
		velocity.x = velocity.x*acceleration + linear

func _decelerate(delta, rate):
	var deceleration = .9
	var linear = 20
	if(abs(velocity.x) < linear):
		velocity.x = 0
	elif(velocity.x > 0):
		velocity.x = velocity.x*deceleration - linear
	elif(velocity.x < 0):
		velocity.x = velocity.x*deceleration + linear

	
	


"""func _on_body_entered(body):
	hide()
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	"""
