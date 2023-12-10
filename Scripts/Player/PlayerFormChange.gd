class_name PlayerFormChange
extends Node

@export var form_change_ui: AnimatedSprite2D
@export var player: CharacterBody2D

var selected_form = 0


signal form_change_open()
signal form_change_close()
signal ability_resource_updated()

func _process(delta):
	if(Input.is_action_just_pressed("form_change")&&PlayerState.form_change_cd<=0):
		PlayerState.form_change_ui_open = true
		form_change_ui.show()
		form_change_ui.frame=0
		form_change_open.emit()
	if(Input.is_action_just_released("form_change")&&PlayerState.form_change_ui_open == true):
		PlayerState.form_change_ui_open = false
		form_change_ui.hide()
		var last_form = PlayerState.form
		PlayerState.form = get_form_from_wheel(selected_form)
		PlayerState.attack_variation = 0
		var new_form = PlayerState.form
		
		if(new_form != last_form && PlayerState.ability_resource<3):
			PlayerState.ability_resource +=1
			ability_resource_updated.emit(PlayerState.ability_resource)
		form_change_close.emit()
		
		if(new_form!= last_form):
			PlayerState.changing_form = true
			PlayerState.last_form = last_form
			PlayerState.form_change_cd = PlayerState.form_change_cd_max
		
		
	if(PlayerState.form_change_ui_open):
		if(Input.is_action_pressed("move_right")):
			selected_form = 1
		if(Input.is_action_pressed("move_left")):
			selected_form = 5

	if(PlayerState.form_change_ui_open):
		form_change_ui.frame = selected_form


func get_form_from_wheel(wheel_index):
	if(wheel_index == 1):
		return "fire"
	if(wheel_index == 5):
		return "ice"
	if(wheel_index ==0):
		return PlayerState.form
