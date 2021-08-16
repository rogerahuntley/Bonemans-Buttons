tool
extends Control

class_name LevelBar

signal group_changed(active_group)

export(NodePath) onready var left_button
export(NodePath) onready var right_button
export(NodePath) onready var _level_label_group
onready var _left_button = get_node(left_button)
onready var _right_button = get_node(right_button)
onready var level_label_group = get_node(_level_label_group)

const level_label_prefab = preload("res://Nodes/UI/LevelLabel.tscn")

var level_labels = {}

var current_group = 0

func _ready():
	_left_button.connect("pressed", self, "left_pressed")
	_right_button.connect("pressed", self, "right_pressed")
	self.connect("group_changed", self, "move_all")
	create_group_labels()

func create_group_labels():
	for group_id in LevelNames.Levels.size():
		var group_name = LevelNames.get_group_name(group_id)
		var group_data = LevelNames.get_group_by_id(group_id)
		add_label(group_id, group_name)

func add_label(id, name):
	var new_label = level_label_prefab.instance()
	new_label.set_text(name)
	new_label.set_id(id)
	level_label_group.add_child(new_label)
	level_labels[id] = new_label

func move_all(current_group_id):
	for id in level_labels:
		var level_label = level_labels[id] as LevelLabel
		level_label.move(current_group_id)

func left_pressed():
	if current_group > 0:
		current_group -= 1
	emit_signal("group_changed", current_group)

func right_pressed():
	if current_group < level_labels.size() - 1:
		current_group += 1
	emit_signal("group_changed", current_group)
