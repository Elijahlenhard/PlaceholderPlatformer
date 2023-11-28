extends Camera2D

@export var target: Node
@export var path: PathFollow2D

var lerp_pos
# Called when the node enters the scene tree for the first time.
func _ready():
	lerp_pos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(target == null):
		return
	var target_position = target.position
	if(target_position.distance_to(position) < 9):
		return
	lerp_pos = lerp(lerp_pos, target_position, 2.5*delta)
	position = snapped(lerp_pos, Vector2(1,1))
	
