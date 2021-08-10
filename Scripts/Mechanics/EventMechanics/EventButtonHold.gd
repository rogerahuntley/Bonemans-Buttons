extends EventMechanicBase

class_name EventButtonHold

export(bool) var trigger_hold_value = true

func on_area_entered(entity: Entity):
	set_active(true)

func on_area_exited(entity: Entity):
	set_active(false)

func event_triggered_on():
	if trigger_name != "":
		GameEvents.emit_signal("event_triggered", trigger_name, trigger_hold_value)

func event_triggered_off():
	if trigger_name != "":
		GameEvents.emit_signal("event_triggered", trigger_name, !trigger_hold_value)

### setters / getters

func set_active(is_active):
	active = is_active
	
	set_appearance(is_active)
	if is_active:
		GameGlobals.event_tween(self, "event_triggered_on")
	else:
		GameGlobals.event_tween(self, "event_triggered_off")
