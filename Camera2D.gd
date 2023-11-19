extends Camera2D

@export var target: Node = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_position = target.position
	position = lerp(position, target_position, 2.5*delta)
