class_name Attack
extends Node2D

@export var attack_node: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var hit_box: CollisionPolygon2D
@export var animation_player: AnimationPlayer

var direction = 1
var damage = 0
var active_for
var knock_back

var flipped
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play()
	sprite.animation_finished.connect(destroy_self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init(root_position, source_direction, dmg, active_frames, offset, attack_variation, z):
	
	if(animation_player!=null):
		animation_player.play("attack_" + str(attack_variation))
	
	if(str(attack_variation) != "0"):
		sprite.animation = "attack_" + str(attack_variation)
	
	sprite.z_index = z
	
	damage = dmg
	active_for = active_frames
	var flip = source_direction.x!=1
	get_parent().position.x+=sign(source_direction.x)*offset
	direction = source_direction.x
	if(flip):
		get_parent().scale.x = -1

	if(root_position != null):
		attack_node.position = root_position
	


func destroy_self():
	attack_node.queue_free()


func _on_animated_sprite_2d_frame_changed():
	return
	if(sprite.frame == active_for-1):
		hit_box.queue_free()
