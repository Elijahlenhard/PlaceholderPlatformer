extends Node2D


signal change_level(level, from_level)




func _on_level_a_transition_area_entered(area):
	change_level.emit("a", "b")
	queue_free()
