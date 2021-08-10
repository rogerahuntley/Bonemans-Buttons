extends EventMechanicBase

class_name EventLever

export(bool) var trigger_state_on = true
export(bool) var trigger_state_off = false

func _ready():
	GameEvents.connect("event_triggered", self, "on_event_triggered")
	set_active(active)

func on_area_entered(entity: Entity):
	set_active(!active)

func on_event_triggered(trigger_name, trigger_state):
	if self.trigger_name == trigger_name:
		if active != trigger_state:
			active = trigger_state
			set_appearance(trigger_state)

func event_triggered_on():
	if trigger_name != "":
		GameEvents.emit_signal("event_triggered", trigger_name, trigger_state_on)

func event_triggered_off():
	if trigger_name != "":
		GameEvents.emit_signal("event_triggered", trigger_name, trigger_state_off)

### setters / getters ###

func set_active(is_active):
	active = is_active
	
	set_appearance(is_active)
	if is_active:
		GameGlobals.event_tween(self, "event_triggered_on")
	else:
		GameGlobals.event_tween(self, "event_triggered_off")
