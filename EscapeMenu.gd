extends CanvasLayer

signal save_pressed
signal load_pressed
signal exit_pressed

signal game_paused
signal game_unpaused

var is_paused = false

func _ready():
	hide()

func _process(delta):
	if (Input.is_action_just_pressed("escape")):
		is_paused = !is_paused
		if (is_paused):
			show()
			game_paused.emit()
		else:
			hide()
			game_unpaused.emit()
		


func _on_save_button_pressed():
	save_pressed.emit()

func _on_load_button_pressed():
	load_pressed.emit()

func _on_settings_button_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	exit_pressed.emit()
