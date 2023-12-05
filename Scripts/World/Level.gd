extends Node2D

signal change_level(from_level, to_level, spawn_location:Vector2)


func _on_level_transition(from_level, to_level, to_level_spawn_location):
	change_level.emit(from_level, to_level, to_level_spawn_location)
