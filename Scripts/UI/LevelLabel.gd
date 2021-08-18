tool
extends Control

class_name LevelLabel

onready var anim_player = $AnimationPlayer as AnimationPlayer
onready var anim_tree = $AnimationTree as AnimationTree

onready var state_machine = anim_tree["parameters/playback"]

onready var label_node = $Label as Label

export(String) onready var group_name setget set_text
export(int) onready var group_id setget set_id

func _ready():
	if state_machine:
		if group_id == 0:
			state_machine.start("center")
		else:
			state_machine.start("right")

func move(id):
	if(group_id < id):
		state_machine.travel("left")
	if group_id == id:
		state_machine.travel("center")
	if(group_id > id):
		state_machine.travel("right")

func set_text(value):
	group_name = value
	label_node = $Label
	if label_node:
		label_node.text = value

func set_id(value):
	group_id = value
