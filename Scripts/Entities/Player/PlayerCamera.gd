extends Camera2D

class_name PlayerCamera

var map_rect
var view_rect

var aspect_ratio: float
var map_ratio: float
var max_width: float
var max_height: float

var scale_factor = 4
var scale_start: Vector2

var tile_size = 16
var tile_count = 45
var tile_zoom = 4

func _ready():
	get_tree().get_root().connect("size_changed", self, "calculate_zoom")
	aspect_ratio = OS.window_size.x / OS.window_size.y
	scale_start = Vector2(OS.window_size.x / scale_factor, OS.window_size.y / scale_factor)
	current = true

func set_camera(map_rect: Rect2, view_rect = Vector2(9, 16)):
	self.map_rect = map_rect
	self.view_rect = view_rect
	limit_left = map_rect.position.x
	limit_top = map_rect.position.y
	limit_right = map_rect.end.x * tile_size
	limit_bottom = map_rect.end.y * tile_size
	map_ratio = map_rect.size.x / map_rect.size.y
	
	max_width = scale_start.x / (map_rect.size.y * tile_size)
	max_height = scale_start.y / (map_rect.size.x * tile_size)
	calculate_zoom()

func calculate_zoom():
	var cur_ratio = OS.window_size.x / OS.window_size.y
	var w_ratio = OS.window_size.x / OS.window_size.y
	var h_ratio = OS.window_size.y / OS.window_size.x
	var x_ratio = scale_start.x / OS.window_size.x
	var y_ratio = scale_start.y / OS.window_size.y
	
	print("cur_ratio: " + str(cur_ratio))
	print("start: " + str(scale_start))
	print("width_ratio: " + str(w_ratio))
	print("height_ratio: " + str(h_ratio))
	print("max_width: " + str(max_width))
	print("max_height: " + str(max_height))
	print("x_ratio: " + str(x_ratio))
	print("y_ratio: " + str(y_ratio))
	
	if w_ratio < max_width || h_ratio < max_height:
		print("seth")
		
	var zoom = x_ratio if cur_ratio < aspect_ratio else y_ratio
	set_zoom(Vector2(zoom, zoom))
	pass
