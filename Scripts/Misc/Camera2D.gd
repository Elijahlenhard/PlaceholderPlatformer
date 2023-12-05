extends Camera2D

@export var target: Node
@export var path: PathFollow2D
@export var camera_bounds: Area2D

var time_since_direction_change =0
var direction = 1


var lerp_pos
# Called when the node enters the scene tree for the first time.
func _ready():
	lerp_pos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print_debug(position)
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
	#if(target_position.distance_to(position) < 9):
	#	return
	
	lerp_pos = lerp(lerp_pos, target_position, 10*delta)
	position = snapped(lerp_pos, Vector2(1,1))
	
	
