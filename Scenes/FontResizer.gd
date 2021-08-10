extends Node

var default_font_sizes = {}
var aspect_ratio: float

func _ready():
	get_tree().get_root().connect("size_changed", self, "resize_font")
	resize_font()

func resize_font():
	var font_nodes = get_tree().get_nodes_in_group("font")
	var win_size = OS.window_size.x
	var des_size = ProjectSettings.get_setting("display/window/size/width")
	var ratio = win_size / des_size
	for font_node in font_nodes:
		var font_prop = font_node.get_font("font")
		if !default_font_sizes.has(font_node):
			default_font_sizes[font_node] = font_prop.size
			font_prop = font_node.get_font("font").duplicate()
		font_prop.size = default_font_sizes[font_node]
		font_prop.size *= x_ratio if cur_ratio < aspect_ratio else y_ratio
		font_node.set("custom_fonts/font", font_prop)

