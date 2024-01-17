class_name PlayerAttack
extends Node

@export var player: CharacterBody2D
@export var sounds: PlayerSounds

signal ability_resource_used(current:int)

var fire_basic: Resource
var fire_ability: Resource
var ice_basic: Resource
var ice_ability: Resource

func _ready():
	fire_basic = preload("res://Scenes/Player/Attacks/FireBasic.tscn")
	fire_ability = preload("res://Scenes/Player/Attacks/FireWave.tscn")
	ice_basic = preload("res://Scenes/Player/Attacks/IceBasic.tscn")
	ice_ability = preload("res://Scenes/Player/Attacks/IceSlam.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("attack")&&PlayerState.attack_cd<=0):
		if(PlayerState.form=="fire"):
			fire_fire_basic()
		if(PlayerState.form=="ice"):
			fire_ice_basic()
	if (Input.is_action_just_pressed("ability")):
		if(PlayerState.form=="fire"):
			fire_ability_fire()
		if(PlayerState.form=="ice"):
			fire_ability_ice()
	
func fire_fire_basic():
	var attack_variation = 1
	var offset = -15
	var z_index = 3
	PlayerState.attack_cd = PlayerState.fire_attack_speed
	print(PlayerState.time_since_basic)
	if(PlayerState.time_since_basic < 1):
		PlayerState.attack_variation+=1
		attack_variation = PlayerState.attack_variation
		if(PlayerState.attack_variation==2):
			PlayerState.attack_variation =0
			PlayerState.attack_cd = PlayerState.fire_combo_cd
			
	else:
		PlayerState.attack_variation =1
	print(attack_variation)
	var attack_node = instantiate_attack(fire_basic)
	if(attack_variation ==2):
		z_index = 1
	var knock_back = Vector2(500, -350)
	attack_node.knock_back = knock_back
	attack_node.init(null, PlayerState.direction, 30, 1, offset, attack_variation, z_index)
	PlayerState.time_since_basic = 0
	sounds.play_fire_form_basic()


func fire_ability_fire():
	if(PlayerState.ability_resource==0):
		return
	PlayerState.fire_wave_cd = PlayerState.fire_wave_max_cd
	var ability_instance = fire_ability.instantiate()
	ability_instance.set_name("fire_wave")
	var attack_node = ability_instance.get_node("Attack")
	player.get_parent().add_child(ability_instance)
	var knock_back = Vector2(1500, -250)
	attack_node.knock_back = knock_back
	attack_node.init(player.position, PlayerState.direction, 25, 2, 40, 0, 3)
	player.velocity.x += sign(PlayerState.direction.x)*-1500
	sounds.play_fire_form_ability()
	PlayerState.ability_resource-=1
	ability_resource_used.emit(PlayerState.ability_resource)
	
	
func fire_ice_basic():
	var attack_variation = 1
	var offset = 30
	var z_index = 3
	print(PlayerState.time_since_basic)
	if(PlayerState.time_since_basic < 2):
		PlayerState.attack_variation+=1
		attack_variation = PlayerState.attack_variation
		if(PlayerState.attack_variation==2):
			PlayerState.attack_variation =0
			PlayerState.attack_cd = PlayerState.fire_combo_cd
		else:
			PlayerState.attack_cd = PlayerState.fire_attack_speed
	
	print(attack_variation)
	var attack_instance = ice_basic.instantiate()
	attack_instance.set_name("attack")
	player.add_child(attack_instance)
	var attack_node = attack_instance.get_node("Attack")
	var knock_back = Vector2(250, -250)
	attack_node.knock_back = knock_back
	attack_node.init(null, PlayerState.direction, 25, 1, offset, attack_variation, z_index)
	PlayerState.time_since_basic = 0

func fire_ability_ice():
	if(PlayerState.ability_resource==0):
		return
	PlayerState.ice_slam_cd=PlayerState.ice_slam_max_cd
	var attack_variation = 0
	var offset = 30
	var z_index = 3
	var ability_instance = ice_ability.instantiate()
	ability_instance.set_name("ice_ability")
	player.add_child(ability_instance)
	var attack_node = ability_instance.get_node("Attack")
	var knock_back = Vector2(250, -750)
	attack_node.knock_back = knock_back
	attack_node.init(null, PlayerState.direction, 50, 1, offset, attack_variation, z_index)
	PlayerState.ability_resource-=1
	ability_resource_used.emit(PlayerState.ability_resource)
	
	
func instantiate_attack(attack) -> Node:
	var attack_instance = attack.instantiate()
	attack_instance.set_name("attack")
	player.add_child(attack_instance)
	return attack_instance.get_node("Attack")
