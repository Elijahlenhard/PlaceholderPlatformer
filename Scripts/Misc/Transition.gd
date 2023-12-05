class_name Transition
extends Area2D

signal player_entered(from_level:String, to_level:String, to_level_spawn_location:Vector2)

@export var from_level: String
@export var to_level: String
@export var to_level_spawn_location: Vector2


func _on_area_entered(area):
	player_entered.emit(from_level, to_level, to_level_spawn_location)
