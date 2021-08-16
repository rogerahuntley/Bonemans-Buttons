extends Node

signal resized

var desired = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"))
var desired_aspect_ratio: float = desired.x / desired.y
onready var actual: Vector2
onready var aspect_ratio: float

enum Orientation {
	Landscape,
	Portrait
}

onready var current_orientation = check_orientation()

var w_ratio 
var h_ratio
var x_ratio
var y_ratio
	
func _ready():
	get_tree().get_root().connect("size_changed", self, "update_values")
	update_values()
	pass

func check_orientation():
	if actual.x > actual.y:
		return Orientation.Landscape
	else:
		return Orientation.Portrait

func update_values():
	actual = get_viewport().get_visible_rect().size
	aspect_ratio = actual.x / actual.y
	current_orientation = check_orientation()
	emit_signal("resized")
	
