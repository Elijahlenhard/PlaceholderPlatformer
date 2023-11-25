extends Resource

class_name WorldData

@export var player_name: String
@export var level: int

@export var has_dash: bool
@export var has_double_jump: bool
@export var has_wall_grab: bool

func _to_string():
	return player_name + ", " + str(level) + ", " + str(has_dash) + ", " + str(has_double_jump) + ", " + str(has_wall_grab)
