tool
extends EventMechanicBase

class_name Goal

export(String) var level_id = "" setget set_level_id

func _ready():
	GameEvents.connect("event_triggered", self, "on_event_triggered")

func on_event_triggered(trigger_name, trigger_state):
	if self.trigger_name == trigger_name:
		set_active(trigger_state)
		# check for residing player
		if trigger_state:
			GameGlobals.tween_node.interpolate_callback(self, 1, "check_player")

func on_area_entered(player: Entity):
	.on_area_entered(player)
	if active:
		change_level(player)

func on_area_exited(player:Entity):
	.on_area_exited(player)

func check_player():
	for entity in entity_array:
		change_level(entity)

func change_level(entity):
	GameEvents.emit_signal("level_completed", level_id)
	if entity is Player:
		GameGlobals.tween_node.interpolate_callback(self, 1, "change_level_callback")
		GameGlobals.tween_node.start()

func change_level_callback():
	GameEvents.emit_signal("level_changed", level_id)

func set_active(is_active):
	active = is_active
	
	set_appearance(is_active)

##### setters / getters #####

func set_level_id(value):
	level_id = value
