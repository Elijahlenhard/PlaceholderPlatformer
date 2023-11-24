extends Node

@export var has_dash: bool:
	get = get_has_dash

@export var has_double_jump: bool:
	get = get_has_double_jump

@export var has_wall_grab: bool:
	get = get_has_wall_grab


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func save_game(world_data):
	var date = Time.get_date_dict_from_system();
	var time = Time.get_time_dict_from_system();
	var FILE_NAME = "PlayerSave-%s_%s_%s_%s_%s_%s" % [date["year"], date["month"], date["day"], 
		time["hour"], time["minute"], time["second"]]
	var result = ResourceSaver.save(FILE_NAME, world_data)
	assert(result == OK)

func load_game(FILE_NAME):
	if ResourceLoader.exists(FILE_NAME):
		var world_data = ResourceLoader.load(FILE_NAME)
		if world_data is WorldData: # Check that the data is valid
			return world_data

func get_has_dash():
	return has_dash

func get_has_double_jump():
	return has_double_jump

func get_has_wall_grab():
	return has_wall_grab
