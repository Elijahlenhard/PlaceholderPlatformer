extends CharacterBody2D


signal health_changed(previous_health: float, new_health:float)


var the_dot

var time = 0

func _ready():
	the_dot = preload("res://Scenes/Misc/theDot.tscn")

func _process(delta):
	return
	if time>.05:
		var dot_instance = the_dot.instantiate()
		dot_instance.set_name("dotTime")
		dot_instance.position = global_position
		get_parent().add_child(dot_instance)
		time =0
	else:
		time+=delta

func _on_player_damage_health_depleted(previous_health, new_health):
	health_changed.emit(previous_health, new_health)
