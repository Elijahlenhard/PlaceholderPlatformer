extends Camera2D

@export var target: Node
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(target == null):
		return
	var target_position = target.position
	position = lerp(position, target_position, 2.5*delta)
