class_name PlayerAttack
extends Node

@export var player: CharacterBody2D
@export var state: PlayerState

var fire_basic
var fire_ability
var ice_basic

func _ready():
	fire_basic = preload("res://Scenes/Attacks/Attack.tscn")
	fire_ability = preload("res://Scenes/Attacks/FireWave.tscn")
	ice_basic = preload("res://Scenes/Attacks/IceBasic.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (Input.is_action_just_pressed("attack")&&state.attack_cd<=0):
		if(state.form=="fire"):
			fire_fire_basic()
		if(state.form=="ice"):
			fire_ice_basic()
	if (Input.is_action_just_pressed("ability")&&state.fire_wave_cd<=0):
		fire_ability_fire()
		
func fire_fire_basic():
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
			state.attack_cd = state.fire_combo_cd
		else:
			state.attack_cd = state.fire_attack_speed
	
	print(attack_variation)
	var attack_instance = fire_basic.instantiate()
	attack_instance.set_name("attack")
	player.add_child(attack_instance)
	var attack_node = attack_instance.get_node("Attack")
	if(attack_variation ==2):
		z_index = 1
	var knock_back = Vector2(400, -200)
	attack_node.init(null, state.direction, 25, 3, offset, attack_variation, z_index, knock_back)
	state.time_since_basic = 0
	
func fire_ability_fire():
	state.fire_wave_cd = state.fire_wave_max_cd
	var ability_instance = fire_ability.instantiate()
	ability_instance.set_name("fire_wave")
	var attack_node = ability_instance.get_node("Attack")
	player.get_parent().add_child(ability_instance)
	var knock_back = Vector2(2000, -400)
	attack_node.init(player.position, state.direction, 50, 5, 780, 0, 3, knock_back)
	player.velocity.x += sign(state.direction.x)*-1500
	
func fire_ice_basic():
	var attack_variation = 1
	var offset = 150
	var z_index = 3
	print(state.time_since_basic)
	if(state.time_since_basic < 2):
		state.attack_variation+=1
		attack_variation = state.attack_variation
		if(attack_variation==3):
			offset = 75
		if(state.attack_variation==3):
			state.attack_variation =0
			state.attack_cd = state.fire_combo_cd
		else:
			state.attack_cd = state.fire_attack_speed
	
	print(attack_variation)
	var attack_instance = ice_basic.instantiate()
	attack_instance.set_name("attack")
	player.add_child(attack_instance)
	var attack_node = attack_instance.get_node("Attack")
	if(attack_variation ==2):
		z_index = 1
	var knock_back = Vector2(400, -200)
	attack_node.init(null, state.direction, 25, 3, offset, attack_variation, z_index, knock_back)
	state.time_since_basic = 0
