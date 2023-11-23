class_name Attack
extends Node2D

@export var attack_node: Node2D
@export var sprite: AnimatedSprite2D

var flipped
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play()
	sprite.animation_finished.connect(destroy_self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init(root_position, direction):
	var flip = direction.x!=1
	sprite.flip_h = flip
	
	if(root_position != null):
		attack_node.position = root_position
	
	if(!flip):
		attack_node.position.x +=50
	else:
		attack_node.position.x -=50

func destroy_self():
	attack_node.queue_free()
