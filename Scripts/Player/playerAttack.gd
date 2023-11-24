class_name PlayerAttack
extends Node

@export var player: CharacterBody2D
@export var state: PlayerState

var fire_basic
var fire_ability

func _ready():
	fire_basic = preload("res://Scenes/Attacks/Attack.tscn")
	fire_ability = preload("res://Scenes/Attacks/FireWave.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("attack")&&state.attack_cd<=0):
		var attack_variation = 1
		var offset = 25
		var z_index = 3
		print(state.time_since_basic)
		if(state.time_since_basic < 2):
			state.attack_variation+=1
			attack_variation = state.attack_variation
			if(attack_variation==3):
				offset = 75
			if(state.attack_variation==3):
				state.attack_variation =0
		
		print(attack_variation)
		state.attack_cd = state.attack_speed
		var attack_instance = fire_basic.instantiate()
		attack_instance.set_name("attack")
		player.add_child(attack_instance)
		var attack_node = attack_instance.get_node("Attack")
		if(attack_variation ==2):
			z_index = 1
		attack_node.init(null, state.direction, 25, 3, offset, attack_variation, z_index)
		state.time_since_basic = 0
	
	if (Input.is_action_just_pressed("ability")&&state.fire_wave_cd<=0):
		state.fire_wave_cd = state.fire_wave_max_cd
		var ability_instance = fire_ability.instantiate()
		ability_instance.set_name("fire_wave")
		player.add_child(ability_instance)
		var attack_node = ability_instance.get_node("Attack")
		attack_node.init(null, state.direction, 50, 5, 780, 0, 3)
