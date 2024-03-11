extends State
class_name RockWispDying
@export var animation: AnimatedSprite2D
@export var hitbox: CollisionShape2D
@export var attack_box = CollisionShape2D


func enter():
	animation.animation = "death"
	animation.play
	animation.animation_finished.connect(destroy_self())
	
	hitbox.disabled =true
	attack_box.disabled=true
	
func exit():
	pass
func update(delta: float):
	pass
func physics_update(delta: float):
	pass

func destroy_self():
	queue_free()
	
