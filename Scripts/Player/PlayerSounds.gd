class_name PlayerSounds
extends Node

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.


func play_fire_form_basic():
	var audioStream = AudioStreamPlayer2D.new()
	var variation = randi_range(1,4)
	audioStream.stream = load("res://Sounds/Player/FireForm/Basic" + str(variation) + ".mp3")
	player.add_child(audioStream)
	audioStream.play()
	

func play_fire_form_ability():
	var audioStream = AudioStreamPlayer2D.new()
	audioStream.stream = load("res://Sounds/Player/FireForm/Ability1.mp3")
	player.add_child(audioStream)
	audioStream.play()
