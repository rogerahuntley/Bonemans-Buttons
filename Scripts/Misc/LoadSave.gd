tool
extends Node

var default_save_data_dict  = {
	"level": "w1l1",
	"completed": ["w1l1"],
	"level_map": {}
}

var save_data_dict = default_save_data_dict.duplicate() setget set_save_data
var save_path = "user://save_data.save"

func _ready():
	load_from_file()

func set_save_data(value):
	save_data_dict = value
	save_to_file()

func save_data(name, value):
	save_data_dict[name] = value
	save_to_file()

func load_data(name):
	if save_data_dict.has(name):
		return save_data_dict.get(name)
	else:
		push_error("value: " + name + " not found in save data")
		return null

func save_to_file():
	var file = File.new()
	file.open(save_path, File.WRITE)
	file.store_var(save_data_dict)
	file.close()

func load_from_file():
	var file = File.new()
	file.open(save_path, File.READ)
	var tempData = file.get_var()
	file.close()
	if tempData:
		for data in tempData:
			save_data_dict[data] = tempData[data]

func set_default_save_data():
	save_data_dict = default_save_data_dict.duplicate()

func wipe_save_data():
	set_default_save_data()
	save_to_file()
	load_from_file()
