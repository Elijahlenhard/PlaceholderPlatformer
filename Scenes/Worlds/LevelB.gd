extends Node2D


signal change_level(level, from_level)

signal form_change_open()
signal form_change_close()


func _on_level_a_transition_area_entered(area):
	change_level.emit("a", "b")
	queue_free()


func _on_player_form_change_open():
	form_change_open.emit()


func _on_player_form_change_close():
	form_change_close.emit()
