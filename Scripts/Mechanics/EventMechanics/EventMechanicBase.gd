extends Area2D

class_name EventMechanicBase

onready var sprite_node = $Sprite as AnimatedSprite

export(bool) var active = false
export(String) var trigger_name

var entity_array = []

func _ready():
	self.connect("area_entered", self, "on_area_entered")
	self.connect("area_exited", self, "on_area_exited")
	set_appearance(active)

func on_area_entered(entity: Entity):
	entity_array.push_back(entity)

func on_area_exited(entity: Entity):
	entity_array.erase(entity)

func set_appearance(is_active):
	if is_active:
		sprite_node.play("on")
	else:
		sprite_node.play("off")
