extends Node

var save_data: Dictionary
var save_path = "user://save_data.save"

func _ready():
	load_from_file()
	pass

func save_data(name, value):
	save_data[name] = value
	save_to_file()

func load_data(name):
	if save_data == {}:
		load_from_file()
	
	if save_data.has(name):
		return save_data[name]
	else:
		push_error("value: " + name + " not found in save data")
		return null

func save_to_file():
	var file = File.new()
	file.open(save_path, File.WRITE)
	file.store_var(save_data)
	file.close()

func load_from_file():
	var file = File.new()
	file.open(save_path, File.READ)
	save_data = file.get_var()
	file.close()

func wipe_save_data():
	save_data = {}
	save_to_file()
