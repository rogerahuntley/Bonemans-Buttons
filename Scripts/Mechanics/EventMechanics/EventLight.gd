extends EventMechanicBase

class_name EventLight

func _ready():
	GameEvents.connect("event_triggered", self, "on_event_triggered")

func on_event_triggered(trigger_name, trigger_state):
	if self.trigger_name == trigger_name:
		if active != trigger_state:
			active = trigger_state
			set_appearance(trigger_state)
