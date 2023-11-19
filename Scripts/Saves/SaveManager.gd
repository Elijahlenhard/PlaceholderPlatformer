extends Node

@export var has_dash: bool:
	get = get_has_dash

@export var has_double_jump: bool:
	get = get_has_double_jump

@export var has_wall_grab: bool:
	get = get_has_wall_grab


# Called when the node enters the scene tree for the first time.
func _ready():
	has_dash = true
	has_double_jump = true
	has_wall_grab = true

func save_game(player):
	var date = Time.get_date_dict_from_system();
	var time = Time.get_time_dict_from_system();
	var FILE_NAME = "PlayerSave-%s_%s_%s_%s_%s_%s" % [date["year"], date["month"], date["day"], 
		time["hour"], time["minute"], time["second"]]
	var result = ResourceSaver.save(FILE_NAME, player)
	assert(result == OK)

func load_game(FILE_NAME):
	if ResourceLoader.exists(FILE_NAME):
		var player = ResourceLoader.load(FILE_NAME)
		if player is PlayerData: # Check that the data is valid
			return player

func get_has_dash():
	return has_dash

func get_has_double_jump():
	return has_double_jump

func get_has_wall_grab():
	return has_wall_grab
