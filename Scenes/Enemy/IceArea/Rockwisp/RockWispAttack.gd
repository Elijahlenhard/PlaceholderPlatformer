extends State
class_name RockWispAttack

@export var animation: AnimatedSprite2D
@export var common: Node
@export var attack_hitbox: CollisionShape2D
@export var enemy: CharacterBody2D

var attack_last_frame = false;


func enter():
	animation.animation = "attack"
	animation.play()
func exit():
	animation.animation = "idle"
	animation.play()
func update(delta: float):
	pass
func physics_update(delta: float):
	if (attack_last_frame):
		attack_hitbox.disabled = true
		attack_last_frame = false
	elif (animation.frame == 8):
		attack_hitbox.disabled = false
		attack_last_frame = true
	if(animation.frame == 18):
		transition.emit(RockWispAttack, "RockWispFollow")
	enemy.move_and_slide()
