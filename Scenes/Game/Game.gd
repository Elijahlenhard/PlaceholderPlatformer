extends Node2D

@export var level_spawns: LevelSpawns

@export var audio_bus: AudioStreamPlayer2D

var pitch_scale = 1.0
var target_pitch_scale = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_level_change(from_level, to_level, spawn_location):
	var new_level = load("res://Scenes/Worlds/Level" + to_level.to_upper() +".tscn")
	get_node("Level"+from_level).queue_free()#kills previous scene
	var level_instance = new_level.instantiate()
	level_instance.set_name("Level"+to_level)
	add_child(level_instance)
	level_instance.change_level.connect(_on_level_change)
	level_instance.get_node("Player").position = spawn_location
	level_instance.get_node("Camera2D").position = spawn_location

