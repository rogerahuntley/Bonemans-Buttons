tool
extends Node

func get_level_metadata(level_name):
	return level_map[level_name]

func get_group_by_id(group_id):
	var group_name = get_group_name(group_id)
	return get_group(group_name)

func get_group_name(group_id):
	return level_groups[group_id]

func get_group(group_name):
	var group_array = []
	for level in level_map:
		if level_map[level].group == group_name:
			group_array.append(level)
	return group_array

enum Levels {
	World1,
	World2,
	World3,
	World4,
	World5,
	Challenge
}

const level_groups = [
	"World 1",
	"World 2",
	"World 3",
	"World 4",
	"World 5",
	"Challenge"
]

const level_map = {
	"w1l1": { "group": "World 1", "path": "res://Levels/World1 - Barrels/Level1.tscn",		"name": "Level 1"},
}
