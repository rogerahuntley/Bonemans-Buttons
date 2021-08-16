tool
extends Control

export(LevelNames.Levels) var current_group = LevelNames.Levels.World1 setget show_group

export(NodePath) var level_grid
onready var _level_grid = get_node(level_grid) as LevelGrid

const level_button_node = preload("res://Nodes/UI/LevelSelectButton.tscn")

export(NodePath) var level_bar = "LevelBar"

onready var _level_bar = get_node(level_bar)

func _ready():
	_level_bar.connect("group_changed", self, "show_group")
	show_group(0)
	
func show_group(value):
	if current_group != value:
		current_group = value
	_level_grid = get_node_or_null(level_grid)
	if _level_grid:
		print(value)
		_level_grid.group_id = value
