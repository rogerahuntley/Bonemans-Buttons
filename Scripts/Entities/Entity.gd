extends Area2D

class_name Entity

onready var sprite_node = $Sprite as AnimatedSprite

onready var current_level: Level setget ,get_current_level

var direction = null

const center_correct_vector = Vector2(.5, .5)

enum Direction {
	Up,
	Right,
	Down,
	Left,
	UpRight,
	UpLeft,
	DownRight,
	DownLeft
}

var DirectionVector = {
	Direction.Up: Vector2(0,-1),
	Direction.Right: Vector2(1,0),
	Direction.Down: Vector2(0,1),
	Direction.Left: Vector2(-1,0),
	Direction.UpRight: Vector2(1,-1),
	Direction.UpLeft: Vector2(-1,-1),
	Direction.DownRight: Vector2(1,1),
	Direction.DownLeft: Vector2(-1,1),
}

var tile_size = 16

var alive = true
var target_tile

onready var current_tile = get_tile_pos() setget set_current_tile

func _init():
	GameEvents.connect("event_triggered", self, "on_event_triggered")

func _ready():
	self.current_level.update_entity_position(self, get_tile_pos())

func on_event_triggered(trigger_name, trigger_state):
	pass

func die():
	alive = false
	current_level.remove_entity(self)
	queue_free()

func check_next_tile(target_tile):
	return current_level.check_collision_at(target_tile)

func check_next_tile_type(target_tile):
	return current_level.get_tile_type_at(target_tile)

func plan_move_in_direction(direction):
	plan_move_to_tile(get_tile_pos()+direction, direction)

func plan_move_to_tile(tile, direction = null):
	target_tile = tile
	self.direction = direction

func push(direction):
	plan_move_in_direction(direction)
	return move(false)

func move(can_push = true):
	# check if space is targeted
	if target_tile == null:
		return false
	# push if entity in space
	if can_push && direction && check_next_tile_type(target_tile) == Level.TileType.Entity:
		var entity = current_level.get_entity_at(target_tile)
		if entity.is_in_group("Pushable"):
			entity.push(direction)
	# attempt to move into space
	if check_next_tile(target_tile):
		set_current_tile(target_tile)
		move_to((target_tile+center_correct_vector)*tile_size)
		target_tile = null
		return true
	# else, clear and cancel
	target_tile = null
	return false

func move_to(target_position):
	GameGlobals.tween_node.interpolate_property(self, "position", position, target_position, 1)
	GameGlobals.tween_node.start()

### setters / getters ###

func get_current_level():
	return GameGlobals.level_node

func set_current_tile(target_tile):
	current_tile = target_tile
	current_level.update_entity_position(self, target_tile)

func get_tile_pos(position = self.position):
	return Vector2(floor(position.x / tile_size), floor(position.y / tile_size))
