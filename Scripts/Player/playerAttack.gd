class_name PlayerAttack
extends Node

@export var player: CharacterBody2D
@export var state: PlayerState

var attack

func _ready():
	attack = preload("res://Attack.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		var attack_instance = attack.instantiate()
		attack_instance.set_name("attack")
		player.add_child(attack_instance)
		var attack_node = attack_instance.get_node("Attack")
		attack_node.init(null, state.direction)

