tool
extends NPEntity

export(Entity.Direction) var facing setget set_facing

export var active = false setget set_active

func _ready():
	pass

func update():
	#if GameGlobals.level_node.get
	var check_tile = get_tile_pos()+DirectionVector[facing]
	var clear = current_level.check_collision_at(check_tile)
	var entity = current_level.get_entity_at(check_tile)
	if entity && entity.is_in_group("Pushable"):
		entity.push(DirectionVector[facing])
		print("push")
	

func check_in_direction():
	pass

##### setters / getters #####

func set_active(value):
	active = value

func set_facing(value):
	print(DirectionVector[value])
	facing = value
