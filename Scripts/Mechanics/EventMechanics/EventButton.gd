extends EventMechanicBase

class_name EventButton

export(bool) var trigger_state = true

func on_area_entered(entity: Entity):
	GameGlobals.event_tween(self, "event_triggered")

func event_triggered():
	if trigger_name != "":
		GameEvents.emit_signal("event_triggered", trigger_name, trigger_state)
