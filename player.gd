extends CharacterBody2D

signal hit

@export var speed = 400
var screen_size
var time_jumping
@export var terminal_velocity = 1
@export var g = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	_apply_gravity(delta)
	
	if Input.is_action_pressed("move_right"):
		velocity.x += (1-velocity.x)/50
	if Input.is_action_pressed("move_left"):
		velocity.x -= (1+velocity.x)/50
	if Input.is_action_pressed("Jump"):
		velocity = _jump(velocity)
	else:
		time_jumping = 0
		
	_apply_gravity(delta)
	
	print_debug(velocity.x)

	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * speed * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

func _apply_gravity(delta):
	if !is_on_floor():
		velocity.y += (terminal_velocity-velocity.y)/50
	elif(velocity.y<0):
		velocity.y = 0
	

func _jump(velocity):
	if time_jumping < 200:
		velocity.y -= 1*get_process_delta_time()
	return velocity
	

"""func _on_body_entered(body):
	hide()
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	"""
