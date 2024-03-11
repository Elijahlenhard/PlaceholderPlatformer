extends Node

@export var animation: AnimatedSprite2D
var rng = RandomNumberGenerator.new()
@export var agro_range: float
@export var move_speed: float
@export var attack_range: float
@export var top_speed: float
@export var attack_charge_time: float


func _process(delta):
	pass

func try_idle_var():
	if(animation.frame == 15 && animation.animation_looped):
		var test = rng.randf()
		if(test > .3):
			animation.animation = "idlevar"
			animation.play
