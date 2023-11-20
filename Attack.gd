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

func init(position_root, flip):
	$AnimatedSprite2D.flip_h = flip
	
	if(!flip):
		position.x +=50
	else:
		position.x -=50
