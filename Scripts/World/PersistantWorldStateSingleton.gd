extends Node

var unlocks: Dictionary

func _ready():
	unlocks["dash"] = true
	unlocks["wall_jump"] = false
	unlocks["ice_form"] = true
	unlocks["fire_form"] = true
