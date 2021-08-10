extends Node

func get_level_metadata(level_name):
	return level_map[level_name]

func get_group(group_name):
	var group_array = []
	for level in level_map:
		if level_map[level].group == group_name:
			group_array.append(level)
	return group_array

export (Dictionary) var level_map = {
	"w1l1": { "group": "World 1", "path": "res://Levels/World1 - Barrels/Level1.tscn",		"name": "Out of Control"},
	"w1l2": { "group": "World 1", "path": "res://Levels/World1 - Barrels/Level2.tscn",		"name": "Any Direction You Like",	"hidden": true },
	"w1l3": { "group": "World 1", "path": "res://Levels/World1 - Barrels/Level3.tscn",		"name": "Nice Slides", 				"hidden": true },
	"w1l4": { "group": "World 1", "path": "res://Levels/World1 - Barrels/Level4.tscn",		"name": "OK now put it together", 	"hidden": true },
	"w2l1": { "group": "World 2", "path": "res://Levels/World2 - Barrel Spots/Level1.tscn", "name": "World EXTREME" },
	"w2l2": { "group": "World 2", "path": "res://Levels/World2 - Barrel Spots/Level2.tscn", "name": "Holy Heck", 				"hidden": true },
	"w2l3": { "group": "World 2", "path": "res://Levels/World2 - Barrel Spots/Level3.tscn", "name": "Holy Heck 2", 				"hidden": true },
}
