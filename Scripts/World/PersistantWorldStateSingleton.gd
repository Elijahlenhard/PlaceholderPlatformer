extends Node

var unlocks: Dictionary
var max_health = 5

func _ready():
	unlocks["dash"] = true
	unlocks["wall_jump"] = true
	unlocks["ice_form"] = true
	unlocks["fire_form"] = true
