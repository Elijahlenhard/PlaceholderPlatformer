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
var effective_frame = 2
var frame_played = false
var flipped
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.play()
	hit_box.disabled=true
	sprite.animation_finished.connect(destroy_self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print_debug(hit_box.disabled)
	if(sprite.frame==effective_frame):
		hit_box.disabled=false
		frame_played = true
	else:
		hit_box.disabled=true

func init(root_position, source_direction, dmg, active_frame, offset, attack_variation, z):
	
	effective_frame = active_frame
	
	if(animation_player!=null):
		animation_player.play("attack_" + str(attack_variation))
	
	if(str(attack_variation) != "0"):
		sprite.animation = "attack_" + str(attack_variation)
	
	sprite.z_index = z
	
	damage = dmg
	var flip = source_direction.x!=1
	get_parent().position.x+=sign(source_direction.x)*offset
	direction = source_direction.x
	if(flip):
		get_parent().scale.x = -1

	if(root_position != null):
		attack_node.position = root_position
	


func destroy_self():
	attack_node.queue_free()
