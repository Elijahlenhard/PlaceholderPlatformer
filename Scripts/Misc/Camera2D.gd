extends Camera2D

@export var target: Node
@export var camera_bounds: CameraBounds

var time_since_direction_change =0
var direction = 1

var final_target: Vector2


var lerp_pos
# Called when the node enters the scene tree for the first time.
func _ready():
	if(camera_bounds!=null):
		lerp_pos = camera_bounds.get_closest_bound_position(target.position)
	else:
		lerp_pos = target.position
	final_target = lerp_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(target == null):
		return
	var target_position = target.position
	
	if(direction != PlayerState.direction.x):
		direction = PlayerState.direction.x
		time_since_direction_change = 0
	
	if(time_since_direction_change <1):
		time_since_direction_change+=delta*.5
	
	var direction_offset = lerp(0, 80, time_since_direction_change)
	direction_offset = 0#TODO 
	target_position.x += PlayerState.direction.x*direction_offset
	var bound_position: Vector2
	if(camera_bounds!=null):
		bound_position = camera_bounds.get_closest_bound_position(target_position)
	else:
		bound_position = target_position
	
	if(final_target.distance_to(bound_position)>5):
		final_target = final_target.move_toward(bound_position, lerp(5, 20, final_target.distance_to(bound_position)/2000))
	else:
		final_target = bound_position
	
	
	
	lerp_pos = lerp(lerp_pos, final_target, 10*delta)
	position = snapped(lerp_pos, Vector2(3,3))
	
