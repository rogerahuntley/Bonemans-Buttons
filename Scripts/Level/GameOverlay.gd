extends Control

export(Dictionary) var menu_map = {}

func _ready():
	GameEvents.connect("menu_opened", self, "on_menu_opened")
	GameEvents.connect("menu_closed", self, "on_menu_closed")
	GameEvents.connect("level_reset", self, "on_level_reset")
	GameEvents.connect("level_changed", self, "on_level_reset")
	pass

func on_menu_opened(menu_name):
	var node: Control = check_nodepath(menu_name)
	node.visible = true

func on_menu_closed(menu_name):
	var node: Control = check_nodepath(menu_name)
	node.visible = false

func on_level_reset(_l = null):
	for menu in menu_map:
		on_menu_closed(menu)

func check_nodepath(menu_name):
	assert(menu_map.has(menu_name))
	if menu_map[menu_name] is NodePath:
		var node = get_node(menu_map[menu_name])
		menu_map[menu_name] = node
		return node
	elif menu_map[menu_name] is Node:
		return menu_map[menu_name]
