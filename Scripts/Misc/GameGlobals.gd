extends Node

var speed = 6

var tween_node: Tween

var level setget set_level, get_level
var level_node setget set_level_node

var tile_size = 16

var event_time = .2
func event_tween(entity, function):
	tween_node.interpolate_callback(entity, event_time, function)
	tween_node.start()

func setup_tween():
	tween_node = Tween.new()
	add_child(tween_node)
	tween_node.playback_speed = speed

func set_level_node(value):
	print(value)
	level_node = value

func set_level(new_level):
	level = new_level
	print(new_level)
	LoadSave.save_data("level", new_level)

func get_level():
	if level == null:
		level = LoadSave.load_data("level")
	return level

func _ready():
	setup_tween()
