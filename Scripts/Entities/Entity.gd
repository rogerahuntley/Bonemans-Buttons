extends Area2D

class_name Entity

onready var tween_node = $Tween as Tween
onready var sprite_node = $Sprite as AnimatedSprite

var current_level: Level = null setget set_level

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

var speed: float setget set_speed
var alive = true
var target_tile

onready var current_tile = get_tile_pos() setget set_current_tile

func _ready():
	set_speed()
	GameEvents.connect("event_triggered", self, "on_event_triggered")
	GameEvents.connect("speed_changed", self, "set_speed")

func on_event_triggered(trigger_id):
	pass

func die():
	alive = false
	current_level.remove_entity(self)
	queue_free()

func check_next_tile(target_tile):
	return current_level.check_collision_at(target_tile)

func plan_move_in_direction(direction):
	plan_move_to_tile(get_tile_pos()+direction)

func plan_move_to_tile(tile):
	target_tile = tile

func move():
	if target_tile == null:
		return false
	if check_next_tile(target_tile):
		set_current_tile(target_tile)
		var center_correct_vector = Vector2(.5, .5)
		move_to((target_tile+center_correct_vector)*tile_size)
		target_tile = null
		return true
	target_tile = null
	return false

func move_to(target_position):
	tween_node.interpolate_property(self, "position", position, target_position, 1)
	tween_node.start()

### setters / getters ###

func set_level(level):
	current_level = level
	current_level.update_entity_position(self, get_tile_pos())
	pass

func set_current_tile(target_tile):
	current_tile = target_tile
	current_level.update_entity_position(self, target_tile)

func get_tile_pos(position = self.position):
	return Vector2(floor(position.x / tile_size), floor(position.y / tile_size))

func set_speed(new_speed = GameGlobals.speed):
	speed = new_speed
	tween_node.playback_speed = new_speed
