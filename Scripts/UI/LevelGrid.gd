tool
extends Control

class_name LevelGrid

export(NodePath) var grid_container
onready var _grid_container = get_node(grid_container) as GridContainer

const level_grid_item_prefab = preload("res://Nodes/UI/LevelGridItem.tscn")

export(LevelNames.Levels) var group_id = LevelNames.Levels.World1 setget set_group_id

func _ready():
	generate_grid(group_id)

func generate_grid(group_id):
	# remove children
	for child in _grid_container.get_children():
		_grid_container.remove_child(child)
	
	# repopulate
	var level_array = LevelNames.get_group_by_id(group_id)
	for level in level_array:
		add_grid_item(level)

func add_grid_item(level_id):
	var level_grid_item = level_grid_item_prefab.instance() as LevelGridItem
	_grid_container.add_child(level_grid_item)
	level_grid_item.set_level_id(level_id)

##### setters / getters #####

func set_group_id(value):
	group_id = value
	_grid_container = get_node_or_null(grid_container)
	if _grid_container:
		generate_grid(value)
