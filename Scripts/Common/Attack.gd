class_name Attack
extends Node2D

@export var attack_node: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var hit_box: CollisionPolygon2D

var direction = 1
var damage = 0
var active_for

var flipped
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play()
	sprite.animation_finished.connect(destroy_self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init(root_position, source_direction, dmg, active_frames, sprite_length, attack_variation, z):
	
	if(attack_variation!= 0):
		sprite.animation = "attack_" + str(attack_variation)
	
	sprite.z_index = z
	
	damage = dmg
	active_for = active_frames
	var flip = source_direction.x!=1
	direction = source_direction.x
	sprite.flip_h = flip
	if(root_position != null):
		attack_node.position = root_position
	
	if(!flip):
		attack_node.position.x +=sprite_length
	else:
		attack_node.position.x -=sprite_length


func destroy_self():
	attack_node.queue_free()


func _on_animated_sprite_2d_frame_changed():
	if(sprite.frame == active_for-1):
		hit_box.queue_free()
