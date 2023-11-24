extends Node2D

signal change_level(level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("level_b")):
		change_level.emit("LevelB")
		queue_free()
