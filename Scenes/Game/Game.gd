extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_a_change_level(level):
	var new_level = load("res://Scenes/Worlds/" + level +".tscn")
	var level_instance = new_level.instantiate()
	level_instance.set_name(level)
	add_child(level_instance)
	level_instance.change_level.connect(_on_level_a_change_level)
