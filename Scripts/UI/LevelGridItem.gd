tool
extends Control

class_name LevelGridItem

var game_scene = "res://Scenes/GameHandler.tscn"

export(NodePath) var check
export(NodePath) var level_name_label
export(NodePath) var button
onready var _check = get_node(check) as Check
onready var _level_name_label = get_node(level_name_label) as Label
onready var _button = get_node(button) as ToolButton

export(String) var level_id setget set_level_id
export(String) var level_name setget set_level_name
export(bool) var level_completed setget set_level_completed

func _ready():
	_button = get_node_or_null(button)
	if _button:
		_button.connect("pressed", self, "pressed")

func pressed():
	if level_completed:
		GameGlobals.level = level_id
		get_tree().change_scene(game_scene)

##### setters / getters #####

func set_level_id(value):
	level_id = value
	self.level_name = LevelNames.get_level_metadata(value).name
	self.level_completed = LoadSave.load_data("completed").has(level_id)

func set_level_name(value):
	level_name = value
	_level_name_label = get_node_or_null(level_name_label)
	if _level_name_label:
		_level_name_label.text = value

func set_level_completed(value):
	level_completed = value
	_check = get_node_or_null(check)
	if _check:
		_check.checked = value
