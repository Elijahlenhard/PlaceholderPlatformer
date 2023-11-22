extends Node2D

var flipped
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite2D.play()

		
	await($AnimatedSprite2D.animation_finished)
	queue_free()

func init(root_position, direction):
	var flip = direction.x!=1
	$AnimatedSprite2D.flip_h = flip
	
	
	position = root_position
	
	if(!flip):
		position.x +=50
	else:
		position.x -=50
