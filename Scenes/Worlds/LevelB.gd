extends Node2D


signal change_level(level)




func _on_level_a_transition_area_entered(area):
	change_level.emit("levelA")
	queue_free()
