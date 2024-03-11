extends State
class_name RockWispIdle

@export var animation: AnimatedSprite2D
@export var common: Node
@export var enemy: CharacterBody2D

func enter():
	animation.animation = "idle"
	animation.play()
func exit():
	pass
func update(delta: float):
	if(animation.animation == "idle"):
		common.try_idle_var()
	elif(animation.frame == 15):
		animation.animation = "idle"
		
	if(enemy.position.distance_to(PlayerState.player_location) <= common.agro_range):
		transition.emit(RockWispIdle, "RockWispFollow")
func physics_update(delta: float):
	pass
