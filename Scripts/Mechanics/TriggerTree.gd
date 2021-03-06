extends Node

class_name TriggerTree

export(Array, String) var input_triggers = []

export(String) var output_trigger_name
export(bool) var output_trigger_state = true

export(bool) var output_state_hold = true

var trigger_states = {} setget ,get_trigger_states

func get_trigger_states():
	return GameGlobals.level_node.trigger_states

enum REQUIRED {
	IF_ANY,
	IF_ALL,
	IF_SOME	
}

export(REQUIRED) var output_trigger_requirement = REQUIRED.IF_ALL
export(int) var if_some_amount = 1

var sent = false

func _ready():
	GameEvents.connect("event_triggered", self, "on_event_triggered")

func on_event_triggered(trigger_name, trigger_state):
	if input_triggers.has(trigger_name):
		check_triggers()

func check_triggers():
	match output_trigger_requirement:
		REQUIRED.IF_ANY:
			for trigger in self.trigger_states:
				if input_triggers.has(trigger) && self.trigger_states[trigger] == true:
					return send_trigger(true)
			return send_trigger(false)
		REQUIRED.IF_ALL:
			print(self.trigger_states)
			for trigger in input_triggers:
				if !self.trigger_states.has(trigger) || self.trigger_states[trigger] == false:
					return send_trigger(false)
			return send_trigger(true)
		REQUIRED.IF_SOME:
			var true_count:int = 0
			for trigger in self.trigger_states:
				if input_triggers.has(trigger) && self.trigger_states[trigger] == true:
					true_count += 1
			if true_count >= if_some_amount:
				return send_trigger(true)
			return send_trigger(false)

func send_trigger(send_state):
	if send_state:
		GameEvents.emit_signal("event_triggered", output_trigger_name, output_trigger_state)
		return true
	else:
		if !output_state_hold:
			GameEvents.emit_signal("event_triggered", output_trigger_name, !output_trigger_state)
		return false
	
	
	
