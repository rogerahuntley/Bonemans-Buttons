extends Node2D

var current_level = null

onready var map_node = $Map as Node
onready var tween_node = $Tween as Tween

func _init():
	GameGlobals.level_handler = self

func _ready():
	GameEvents.connect("level_changed", self, "on_level_changed")
	GameEvents.connect("level_completed", self, "on_level_completed")
	GameEvents.connect("level_reset", self, "on_level_reset")
	GameEvents.connect("player_killed", self, "on_player_killed")
	load_level(GameGlobals.level)

func on_player_killed():
	tween_node.interpolate_callback(self, 1, "load_level", GameGlobals.level)
	tween_node.start()

func on_level_changed(level_name):
	# set level as last loaded
	load_level(level_name)

func on_level_completed(level_name):
	var completed = LoadSave.load_data("completed") as Array
	if !completed.has(level_name):
		completed.append(level_name)

func on_level_reset():
	on_level_changed(GameGlobals.level)

func load_level(level_name):
	# delete old level
	if current_level:
		current_level.queue_free()
	
	# construct new level
	GameGlobals.level = level_name
	var level_dat = LevelNames.level_map[level_name]
	var level_scene = load(level_dat.path)
	var level = level_scene.instance()
	map_node.add_child(level)
	current_level = level
