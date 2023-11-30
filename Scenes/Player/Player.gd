extends CharacterBody2D

@export var player_move: PlayerMove


signal health_changed(previous_health: float, new_health:float)

signal form_change_open()
signal form_change_close()


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

func _on_player_form_change_open():
	get_tree().paused = true
	form_change_open.emit()


func _on_player_form_change_close():
	get_tree().paused = false
	form_change_close.emit()
