class_name EnemyState
extends Node

@export var run_direction:int = 1

@export var health:int = 100

var dying = false

@export var contact_damage = 1
var attacking = false

@export var attack_max_cd = 3

var attack_cd = 3
var sees_player = false
