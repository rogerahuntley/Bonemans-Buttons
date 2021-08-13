extends Button

class_name GroupSelectButton

signal group_pressed(group_name)

func _ready():
	self.connect("pressed", self, "on_pressed")

func on_pressed():
	emit_signal("group_pressed", self.text)
