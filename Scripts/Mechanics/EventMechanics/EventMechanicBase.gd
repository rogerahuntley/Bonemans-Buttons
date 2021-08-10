extends Area2D

class_name EventMechanicBase

onready var sprite_node = $Sprite as AnimatedSprite

export(bool) var active = false
export(String) var trigger_name

func _ready():
	self.connect("area_entered", self, "on_area_entered")
	self.connect("area_exited", self, "on_area_exited")
	set_appearance(active)

func on_area_entered(entity: Entity):
	pass

func on_area_exited(entity: Entity):
	pass

func set_appearance(is_active):
	if is_active:
		sprite_node.play("on")
	else:
		sprite_node.play("off")
