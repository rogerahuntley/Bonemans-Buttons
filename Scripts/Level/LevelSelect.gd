extends Control

const button_path = "res://Nodes/UI/LevelSelectButton.tscn"
var button_node = preload(button_path)

export(NodePath) onready var vbox_node = get_node(vbox_node) as VBoxContainer

func _ready():
	for level in LevelNames.level_map.keys():
		var button = button_node.instance()
		vbox_node.add_child(button)
		button.level_name = level
		button.text = LevelNames.level_map[level].name
