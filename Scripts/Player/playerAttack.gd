class_name PlayerAttack
extends Node

@export var player: CharacterBody2D
@export var state: PlayerState


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		var attack = load("res://Attack.tscn")
		var attack_instance = attack.instantiate()
		attack_instance.set_name("attack")
		add_child(attack_instance)
		attack_instance.init(player.position, state.direction)

