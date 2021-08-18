extends Camera2D

class_name PlayerCamera

export(float) var scale_factor = 4

var map_rect: Rect2 setget set_map_rect
var map_size: Vector2
var scaled_map_size: Vector2 setget ,get_scaled_map_size

var desired: Vector2 setget ,get_desired
var actual: Vector2 setget ,get_actual
var tile_size: int setget ,get_tile_size

var limits: Rect2 setget set_limits

func _ready():
	AspectAdjust.connect("resized", self, "calculate_zoom")
	calculate_zoom()
	current = true

func calculate_zoom():
	# calculate tighter size
	var big_enough = self.scaled_map_size / self.actual
	
	var bigger_side = big_enough.x if big_enough.x > big_enough.y else big_enough.y
	if bigger_side > 1:
		bigger_side = 1
	
	# set zoom value
	var zoom_val = 1.0 / scale_factor * bigger_side
	if zoom_val != 0:
		self.zoom = Vector2(zoom_val, zoom_val)
	
	# calculate adjusted limits
	var limit_diffs = Vector2(round(self.actual.x * zoom.x) - limits.size.x, round(self.actual.y * zoom.y) - limits.size.y)
	
	if limit_diffs.x >= 1:
		limit_left = limits.position.x - limit_diffs.x / 2
		limit_right = limits.end.x + limit_diffs.x / 2
		limit_top = limits.position.y
		limit_bottom = limits.end.y
	
	if limit_diffs.y >= 1:
		limit_top = limits.position.y - limit_diffs.y / 2
		limit_bottom = limits.end.y + limit_diffs.y / 2
		limit_left = limits.position.x
		limit_right = limits.end.x

### setters / getters ###

func set_map_rect(map):
	map_rect = map
	map_size = map.size * self.tile_size
	set_limits(map_size)
	calculate_zoom()

func set_limits(value):
	if value is Rect2:
		limits = value
	elif value is Vector2:
		limits.position.y = map_rect.position.y
		limits.position.x = map_rect.position.x + 1
		limits.size.y = map_rect.position.y + value.y
		limits.size.x = map_rect.position.x + value.x
	
	limit_top = limits.position.y
	limit_left = limits.position.x
	limit_bottom = limits.end.y
	limit_right = limits.end.x

func get_scaled_map_size():
	return map_size * scale_factor

func get_desired():
	return AspectAdjust.desired

func get_actual():
	return AspectAdjust.actual

func get_tile_size():
	return GameGlobals.tile_size
