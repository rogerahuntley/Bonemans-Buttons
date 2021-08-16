extends Node2D

class_name Level

export(String) var level_id = "w1l1"
export(LevelNames.Levels) var group_id = LevelNames.Levels.World1
export(String) var level_name = "placeholder name"
export(String) var to_level = "w1l1"

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
	set_entities()
	set_camera()
	set_goal()

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

func set_camera():
	player_node.camera_node.map_rect = get_rect()

func set_goal():
	var goals = get_tree().call_group("goal", "set_level_id", to_level)

func get_rect():
	return tilemap_node.get_used_rect()
	#return Rect2(tilemap_node.position.x, tilemap_node.position.y, tilemap_node.get_used_rect() GameGlobals.tile_size)

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
