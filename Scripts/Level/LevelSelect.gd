extends Control

const group_button_path = "res://Nodes/UI/GroupSelectButton.tscn"
var group_button_node = preload(group_button_path)
const level_button_path = "res://Nodes/UI/LevelSelectButton.tscn"
var level_button_node = preload(level_button_path)

onready var groups_node = $Worlds
onready var groups_parent = $Worlds/VBoxPanel/VBoxContainer
onready var levels_node = $Levels
onready var levels_parent = $Levels/VBoxPanel/VBoxContainer
onready var levels_label = $Levels/LevelLabel
onready var levels_back = $Levels/Back

export(NodePath) onready var vbox_node = get_node(vbox_node) as VBoxContainer

func _ready():
	create_group_buttons()

func create_group_buttons():
	# remove children
	for child in groups_parent.get_children():
		groups_parent.remove_child(child)
	
	#create new ones
	for group in LevelNames.level_groups:
		if LevelNames.get_group(group).size() > 0:
			var button = group_button_node.instance()
			groups_parent.add_child(button)
			button.group_name = group
			button.text = group
			button.connect("group_pressed", self, "create_level_buttons")
	
	display_groups()

func create_level_buttons(group_name):
	# remove children
	for child in levels_parent.get_children():
		levels_parent.remove_child(child)
	
	#create new ones
	levels_label.text = group_name
	levels_back.connect("show_groups", self, "display_groups")
	
	for level in LevelNames.get_group(group_name):
		if !("hidden" in LevelNames.level_map[level]) || !(LevelNames.level_map[level].hidden):
			var button = level_button_node.instance()
			levels_parent.add_child(button)
			button.level_name = level
			button.text = LevelNames.level_map[level].name
	
	display_levels()

func display_groups():
	levels_node.visible = false
	groups_node.visible = true

func display_levels():
	groups_node.visible = false
	levels_node.visible = true
