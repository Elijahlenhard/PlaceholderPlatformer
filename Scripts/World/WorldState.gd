extends Node

class_name WorldState

var state: WorldData = WorldData.new()

func _ready():
	state.player_name = "Garot"
	state.level = 3
	
	state.has_dash = true
	state.has_wall_grab = true
	state.has_double_jump = false
	
