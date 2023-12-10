class_name EnemySounds
extends Node

@export var enemy: CharacterBody2D
@export var hit_sound_file: String

func play_hit_sound():
	var audioStream = AudioStreamPlayer2D.new()
	var random_pitch = randf_range(.9,1.1)
	audioStream.stream = load(hit_sound_file)
	enemy.get_parent().add_child(audioStream)
	audioStream.position = enemy.position
	audioStream.pitch_scale = random_pitch
	audioStream.volume_db = -7
	audioStream.play()
