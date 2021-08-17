tool
extends Control

class_name Check

export(NodePath) var check_box
export(NodePath) var check_mark
export(NodePath) var check_ex
onready var _check_box = get_node(check_box) as TextureRect
onready var _check_mark = get_node(check_mark) as TextureRect
onready var _check_ex = get_node(check_ex) as TextureRect

export(bool) var checked setget set_checked
export(bool) var locked setget set_locked

func set_checked(value):
	checked = value
	_check_mark = get_node_or_null(check_mark)
	if value && locked:
		self.locked = false
	if _check_mark:
		_check_mark.visible = value

func set_locked(value):
	locked = value
	if value && checked:
		self.checked = false
	_check_ex = get_node_or_null(check_ex)
	if _check_ex:
		_check_ex.visible = value
