extends EventMechanicBase

class_name Goal

export var level_name: String

func _ready():
	GameEvents.connect("event_triggered", self, "on_event_triggered")

func on_event_triggered(trigger_name, trigger_state):
	if self.trigger_name == trigger_name:
		set_active(trigger_state)
		# check for residing player
		if trigger_state:
			print(entity_array)
			for entity in entity_array:
				if entity is Player:
					change_level()

func on_area_entered(player: Entity):
	.on_area_entered(player)
	if active && player is Player:
		change_level()

func change_level():
		GameGlobals.tween_node.interpolate_callback(self, 1, "change_level_callback")
		GameGlobals.tween_node.start()

func change_level_callback():
	GameEvents.emit_signal("level_changed", level_name)

func set_active(is_active):
	active = is_active
	
	set_appearance(is_active)
