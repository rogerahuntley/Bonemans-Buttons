extends Node2D

class_name Level

onready var tilemap_node = $TileMap as TileMap
onready var entities_node = $Entities as Node
onready var player_node = $Entities/Player

enum TileType {
	Empty,
	Environment,
	Entity
}

var entity_map = {}

var collidable_tiles = [0]

func _ready():
	GameEvents.connect("player_moved", self, "move_entities")
	set_entities()
	set_camera()

func _process(_e):
	get_tree().call_group("Player", "plan_update")
	get_tree().call_group("NPEntity", "plan_update")
	get_tree().call_group("Player", "update")

func move_entities():
	get_tree().call_group("NPEntity", "update")
	

func set_entities():
	for entity in entities_node.get_children():
		entity.current_level = self
	pass

func set_camera():
	player_node.camera_node.set_camera(get_rect())

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
