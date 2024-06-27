tool
extends Node

var levels_directory: String = "res://Levels/"
var level_map_path = "res://Levels/Level_Map.tres"
var level_map_res = load("res://Levels/Level_Map.tres")

var level_map setget set_level_map,get_level_map

enum Levels {
	World1,
	World2,
	World3,
	World4,
	World5,
	Challenge
}

const level_groups = [
	"World 1",
	"World 2",
	"World 3",
	"World 4",
	"World 5",
	"Challenge"
]

func _ready():
	if OS.is_debug_build():
		build_level_map()

func get_level_metadata(level_name):
	return self.level_map[level_name]

func get_group_by_id(group_id):
	var group_array = []
	for level in self.level_map:
		if self.level_map[level].group == group_id:
			group_array.append(level)
	return group_array

func get_group_name(group_id):
	return level_groups[group_id]

func build_level_map():
	var files = get_all_files(levels_directory)
	var level_map = {}
	for file in files:
		var file_dict = {}
		var load_level = load(file).instance()
		var hidden = load_level.hidden
		if !hidden:
			file_dict["path"] = file
			file_dict["group"] = load_level.group_id
			file_dict["name"] = load_level.level_name
			level_map[load_level.level_id] = file_dict
	self.level_map = level_map
	pass

func get_all_files(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	var file_name = dir.get_next()
	while(file_name != ""):
		if file_name == "." || file_name == ".." || file_name == "Level_Map.tres":
			# ignore, do nothing
			pass
		elif dir.current_is_dir():
			files.append_array(get_all_files(path + file_name))
		else:
			files.append(path + "/" + file_name)
		file_name = dir.get_next()
	
	dir.list_dir_end()
	return files

##### setters / getters #####

func set_level_map(value):
	level_map_res.level_map = value
	ResourceSaver.save(level_map_path, level_map_res)

func get_level_map():
	return level_map_res.level_map
