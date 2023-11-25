extends Node2D

signal change_level(level)


func _on_level_b_tranisition_area_entered(area):
	change_level.emit("LevelB")
	queue_free()
