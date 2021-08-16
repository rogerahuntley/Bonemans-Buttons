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

func set_checked(value):
	checked = value
	_check_mark = get_node_or_null(check_mark)
	_check_ex = get_node_or_null(check_ex)
	if _check_mark && _check_ex:
		_check_mark.visible = value
		_check_ex.visible = !value
