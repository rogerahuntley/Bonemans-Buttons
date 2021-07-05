extends Node2D

export var test = "w0l1"

var current_level = null
var last_loaded_level = null

onready var map_node = $Map as Node
onready var tween_node = $Tween as Tween
export(NodePath) onready var name_node = get_node(name_node) as Control
export(NodePath) onready var name_label_node = get_node(name_label_node) as Label

func _ready():
	GameEvents.connect("level_changed", self, "_on_level_changed")
	GameEvents.connect("player_killed", self, "_on_player_killed")
	load_level(test)

func _on_player_killed():
	tween_node.interpolate_callback(self, 1, "load_level", last_loaded_level)
	tween_node.start()

func _on_level_changed(level_name):
	# set level as last loaded
	LoadSave.save_data("last_level_loaded", level_name)
	load_level(level_name)

func load_level(level_name):
	# delete old level
	if current_level:
		current_level.queue_free()
	
	# construct new level
	last_loaded_level = level_name
	var level_dat = LevelNames.level_map[level_name]
	var level_scene = load(level_dat.path)
	var level = level_scene.instance()
	map_node.add_child(level)
	name_label_node.text = level_dat.name
	current_level = level
