extends Node2D

@export var level_spawns: LevelSpawns

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_change(level, from_level):
	var new_level = load("res://Scenes/Worlds/Level" + level.to_upper() +".tscn")
	var level_instance = new_level.instantiate()
	level_instance.set_name("level"+level)
	add_child(level_instance)
	level_instance.change_level.connect(_on_level_change)
	var enter_pos = level_spawns.get(level + "_from_" + from_level)
	print_debug(enter_pos)
	level_instance.get_node("Player").position = enter_pos
	level_instance.get_node("Camera2D").position = enter_pos
