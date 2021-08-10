extends Node

func get_level_metadata(level_name):
	return level_map[level_name]

func get_group(group_name):
	var group_array = []
	for level in level_map:
		if level_map[level].group == group_name:
			group_array.append(level)
	return group_array

export(Array, String) var level_groups = [
	"World 1",
	"Challenge"
]

export (Dictionary) var level_map = {
	"w1l1": { "group": "World 1", "path": "res://Levels/World1 - Barrels/Level1.tscn",		"name": "Level 1"},
	"w1l2": { "group": "World 1", "path": "res://Levels/World1 - Barrels/Level2.tscn",		"name": "Level 2"},
	"w1l3": { "group": "World 1", "path": "res://Levels/World1 - Barrels/Level3.tscn",		"name": "Level 3"},
	"w1l4": { "group": "World 1", "path": "res://Levels/World1 - Barrels/Level4.tscn",		"name": "Level 4"},
	"w1l5": { "group": "World 1", "path": "res://Levels/World1 - Barrels/Level5.tscn",		"name": "Level 5"},
	"w1l6": { "group": "World 1", "path": "res://Levels/World1 - Barrels/Level6.tscn",		"name": "Level 6"},
	"w1l7": { "group": "World 1", "path": "res://Levels/World1 - Barrels/Level7.tscn",		"name": "Level 7"},
	"w1l8": { "group": "World 1", "path": "res://Levels/World1 - Barrels/Level8.tscn",		"name": "Level 8"},
	"w1l9": { "group": "World 1", "path": "res://Levels/World1 - Barrels/Level9.tscn",		"name": "Level 9"},
	
	"w2l1": { "group": "Challenge", "path": "res://Levels/World2 - Barrel Spots/Level1.tscn", "name": "World EXTREME" },
	"w2l2": { "group": "Challenge", "path": "res://Levels/World2 - Barrel Spots/Level2.tscn", "name": "Holy Heck"},
	"w2l3": { "group": "Challenge", "path": "res://Levels/World2 - Barrel Spots/Level3.tscn", "name": "Holy Heck 2"},
}
