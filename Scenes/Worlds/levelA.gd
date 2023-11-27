extends Node2D

signal change_level(level, from_level)




func _on_level_b_tranisition_area_entered(area):
	change_level.emit("b", "a")
	queue_free()


func _on_level_c_transition_area_entered(area):
	change_level.emit("c", "a")
	queue_free()
