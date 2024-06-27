extends Node2D

class_name Level

export(String) var level_id = "w1l1"
export(LevelNames.Levels) var group_id = LevelNames.Levels.World1
export(String) var level_name = "placeholder name"
export(String) var to_level = "w1l1"
export(bool) var hidden = false
export(bool) var last_level = false

onready var tilemap_node = $TileMap as TileMap
onready var entities_node = $Entities as Node
onready var player_node = $Entities/Player

var level_handler_path = "LevelViewport/Viewport/LevelHandler"
var level_handler_scene_path = "res://Scenes/GameHandler.tscn"

var trigger_states = {}

enum TileType {
	Empty,
	Environment,
	Entity
}

var entity_map = {}

var collidable_tiles = [0]

func _init():
	GameGlobals.level_node = self

func _ready():
	check_for_level_handler()
	GameEvents.connect("player_moved", self, "move_entities")
	GameEvents.connect("event_triggered", self, "on_event_triggered")
	GameEvents.connect("level_completed", self, "on_level_completed")
	set_entities()
	set_camera()

func _process(_e):
	get_tree().call_group("Player", "plan_update")
	get_tree().call_group("NPEntity", "plan_update")
	get_tree().call_group("Player", "update")

func on_event_triggered(trigger_name, trigger_state):
	trigger_states[trigger_name] = trigger_state

func move_entities():
	get_tree().call_group("NPEntity", "update")

func set_entities():
	for entity in entities_node.get_children():
		entity.current_level = self
	pass

func unlock_level(level_id):
	LoadSave.load_data("unlocked").append(level_id)
	
func set_camera():
	player_node.camera_node.map_rect = get_rect()

func on_level_completed(level_id):
	unlock_level(to_level)
	if last_level:
		GameGlobals.event_tween(self, "to_menu")	
	else:
		GameGlobals.event_tween(self, "change_level")

func change_level():
	GameEvents.emit_signal("level_changed", to_level)

func to_menu():
	GameEvents.launch_level_select()

func get_rect():
	return tilemap_node.get_used_rect()

func check_collision_at(position):
	var tile_type = get_tile_type_at(position)
	if tile_type == TileType.Empty:
		return true
	else:
		return false

func get_tile_type_at(position):
	var tile_index = tilemap_node.get_cellv(position)
	tilemap_node.z_index
	if !collidable_tiles.has(tile_index):
		return TileType.Environment
	else:
		for entity in entity_map:
			if entity_map[entity] == position:
				return TileType.Entity
	return TileType.Empty

func get_entity_at(position):
	for entity in entity_map:
		if entity_map[entity] == position:
			return entity

func update_entity_position(entity, position):
	entity_map[entity] = position

func remove_entity(entity):
	entity_map.erase(entity)

func check_for_level_handler():
	if !GameGlobals.level_handler:
		GameGlobals.level = level_id
		get_tree().change_scene(level_handler_scene_path)
