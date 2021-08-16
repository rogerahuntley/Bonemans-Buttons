tool
extends Control

export(NodePath) var label
export(NodePath) var button
onready var _label = get_node(label) as Label
onready var _button = get_node(button) as TextureButton

export(String) var text = "" setget set_text
export(Script) var button_script setget set_button_script

func set_text(value):
	text = value
	_label = get_node_or_null(label)
	if _label:
		_label.text = value

func set_button_script(value):
	button_script = value
	_button = get_node_or_null(button)
	if _button:
		_button.set_script(value)
