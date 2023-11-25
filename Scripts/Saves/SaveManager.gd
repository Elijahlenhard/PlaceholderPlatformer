class_name SaveManager

extends Node

var save_path: String = "user://saves/"

@export var world_state: WorldState

@export var has_dash: bool:
	get = get_has_dash

@export var has_double_jump: bool:
	get = get_has_double_jump

@export var has_wall_grab: bool:
	get = get_has_wall_grab


# Called when the node enters the scene tree for the first time.
func _ready():
	verify_save_directory(save_path)

func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)

func save_game(world_data):
	var date = Time.get_date_dict_from_system()
	var time = Time.get_time_dict_from_system()
	var FILE_NAME = "PlayerSave-%s_%s_%s_%s_%s_%s.tres" % [date["year"], date["month"], date["day"], 
		time["hour"], time["minute"], time["second"]]
	var result = ResourceSaver.save(world_data, save_path + FILE_NAME)
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


func _on_escape_menu_save_pressed():
	save_game(world_state.state)


func _on_escape_menu_load_pressed():
	var dir = DirAccess.get_files_at(save_path)
	var recent = dir[0]
	for file_name in dir:
		if FileAccess.get_modified_time(file_name) > FileAccess.get_modified_time(recent):
			recent = file_name
		
	var data = load_game(save_path + recent)
	print(data._to_string())


func _on_escape_menu_exit_pressed():
	get_tree().quit()
