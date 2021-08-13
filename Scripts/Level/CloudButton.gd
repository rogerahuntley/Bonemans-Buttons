tool
extends Control

export(String) var text = "" setget set_text
export(Script) var button_script setget set_button_script

func set_text(value):
	text = value
	var label = $Label
	if label:
		label.text = value

func set_button_script(value):
	button_script = value
	var button = $Button
	if button:
		button.set_script(value)
