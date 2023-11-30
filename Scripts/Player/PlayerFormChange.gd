class_name PlayerFormChange
extends Node

@export var state: PlayerState
@export var form_change_ui: AnimatedSprite2D

var selected_form = 0


signal form_change_open()
signal form_change_close()

func _process(delta):
	if(Input.is_action_just_pressed("form_change")):
		state.form_change_ui_open = true
		form_change_ui.show()
		form_change_ui.frame=0
		form_change_open.emit()
	if(Input.is_action_just_released("form_change")):
		state.form_change_ui_open = false
		form_change_ui.hide()
		state.form = get_form_from_wheel(selected_form)
		form_change_close.emit()
		
		
	if(state.form_change_ui_open):
		if(Input.is_action_pressed("move_right")):
			selected_form = 1
		if(Input.is_action_pressed("move_left")):
			selected_form = 5

	if(state.form_change_ui_open):
		form_change_ui.frame = selected_form


func get_form_from_wheel(wheel_index):
	if(wheel_index == 1):
		return "fire"
	if(wheel_index == 5):
		return "ice"
	if(wheel_index ==0):
		return state.form
