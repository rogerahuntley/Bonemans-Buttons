extends Node

class_name TriggerTree

export(Array, String) var input_triggers = []

export(String) var output_trigger_name
export(bool) var output_trigger_state

var trigger_states = {} setget ,get_trigger_states

func get_trigger_states():
	print(GameGlobals.level_node is Level)
	print(GameGlobals.level_node)
	return GameGlobals.level_node.trigger_states

enum REQUIRED {
	IF_ANY,
	IF_ALL,
	IF_SOME	
}

export(REQUIRED) var output_trigger_requirement
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
					send_trigger()
		REQUIRED.IF_ALL:
			print(self.trigger_states)
			for trigger in input_triggers:
				print(trigger)
				if !self.trigger_states.has(trigger) || self.trigger_states[trigger] == false:
					return false
			send_trigger()
		REQUIRED.IF_SOME:
			var true_count:int = 0
			for trigger in self.trigger_states:
				if input_triggers.has(trigger) && self.trigger_states[trigger] == true:
					true_count += 1
			if true_count >= if_some_amount:
				send_trigger()

func send_trigger():
	if !sent:
		GameEvents.emit_signal("event_triggered", output_trigger_name, output_trigger_state)
		sent = true
