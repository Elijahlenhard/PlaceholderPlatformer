class_name PlayerStateSingleton
extends Node

@export var direction = Vector2(0,1)
var time_jumping =0
@export var max_jump_time = .66

var running_frame = 0

@export var g = 1
var jump_primed = -1
var jump_held
var dash_time = 0
var is_dashing = false
var dash_cd = 1.5
var remaining_dash_cd = 0
var dash_length = .2

var time_since_floor =.07
var coyote_time = .07

var is_jumping = false

var can_wall_jump = false
var is_wall_jumping = false
var wall_jump_time = .1
var wall_jump_direction =1
var time_since_wall_jump = .2
var time_since_wall = 0
var i_frames = 0

var changing_form = false
var form_change_ui_open = false
var form_change_cd = 0
var form_change_cd_max = 5
var form = "fire"
var last_form = "fire"

var attack_cd = 0
var fire_attack_speed = .3
var fire_combo_cd = .3
var health = 3
var fire_wave_cd = 0
var fire_wave_max_cd = 7
var ice_slam_cd = 0
var ice_slam_max_cd = 6
var attack_held_for = 0

var attack_variation = 1
var time_since_basic = 2


var ability_resource = 2
var ability_resource_charge = 0
var seconds_per_resource = 5

func _ready():
	health=PersistantWorldState.max_health
