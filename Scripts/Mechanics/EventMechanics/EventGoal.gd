extends EventMechanicBase

class_name Goal

export var level_name: String

func _ready():
	GameEvents.connect("event_triggered", self, "on_event_triggered")

func on_event_triggered(trigger_name, trigger_state):
	if self.trigger_name == trigger_name:
		if active != trigger_state:
			active = trigger_state
			set_appearance(trigger_state)

func on_area_entered(player: Entity):
	if active && player is Player:
		GameGlobals.tween_node.interpolate_callback(self, 1, "change_level")
		GameGlobals.tween_node.start()

func change_level():
	GameEvents.emit_signal("level_changed", level_name)

func set_active(is_active):
	active = is_active
	
	set_appearance(is_active)
