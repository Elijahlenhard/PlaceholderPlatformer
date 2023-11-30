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
	#pitch_scale=lerp(pitch_scale, target_pitch_scale, .025)
	#if(1-pitch_scale<.01 && target_pitch_scale == 1):
	#	pitch_scale = target_pitch_scale
	#AudioServer.playback_speed_scale = pitch_scale
	#var pitch_shift:AudioEffectPitchShift = AudioServer.get_bus_effect(0,0)
	#pitch_shift.pitch_scale = lerp(1, 2, (1-pitch_scale)/.5)
	#if(pitch_scale ==1):
		#AudioServer.get_bus_effect(0,0).pitch_scale =1
	#print_debug(AudioServer.get_bus_effect(0,0).pitch_scale)
	


func _on_level_change(level, from_level):
	var new_level = load("res://Scenes/Worlds/Level" + level.to_upper() +".tscn")
	var level_instance = new_level.instantiate()
	level_instance.set_name("level"+level)
	add_child(level_instance)
	level_instance.change_level.connect(_on_level_change)
	level_instance.form_change_open.connect(_on_level_b_form_change_open)
	level_instance.form_change_close.connect(_on_level_b_form_change_close)
	var enter_pos = level_spawns.get(level + "_from_" + from_level)
	print_debug(enter_pos)
	level_instance.get_node("Player").position = enter_pos
	level_instance.get_node("Camera2D").position = enter_pos


func _on_level_b_form_change_close():
	target_pitch_scale=1.0


func _on_level_b_form_change_open():
	target_pitch_scale=0.8
	print_debug(target_pitch_scale)
