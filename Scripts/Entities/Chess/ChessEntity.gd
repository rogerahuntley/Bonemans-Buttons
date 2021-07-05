extends NPEntity

class_name ChessEntity

export(Entity.Direction) var current_direction

export(bool) onready var active setget set_active
export(int, 0, 99) var activate_trigger = 0
export(int, 0, 99) var deactivate_trigger = 0

var target_entity

func _ready():
	set_active(active)

func plan_update():
	target_tile = null
	if active:
		target_entity = check_attack()
		if target_entity is Player:
			pass
		else:
			plan_move()

func update():
	if active:
		if !target_entity:
			move()
		else:
			attack_target(target_entity)
			target_entity = null

func plan_move():
	if DirectionVector.has(current_direction):
		plan_move_in_direction(DirectionVector[current_direction])

func on_event_triggered(trigger_id):
	if !active && trigger_id == activate_trigger:
		set_active(true)
	elif trigger_id == deactivate_trigger:
		set_active(false)

func build_check_spots():
	var check_spots: Array
	return check_spots

func check_attack():
	var check_spots = build_check_spots()
		
	for corner in check_spots:
		var check_spot = get_tile_pos()+DirectionVector[corner]
		for entity in get_tree().get_nodes_in_group("Player"):
			if entity.current_tile == check_spot:
				return entity
		for entity in get_tree().get_nodes_in_group("Entity"):
			if entity.current_tile == check_spot:
				return entity

func attack_target(target: Entity):
	move_to((target.current_tile + Vector2(.5, .5)) * target.tile_size)
	target.tween_node.interpolate_callback(target, 1, "die")
	target.tween_node.start()

### setters / getters

func set_active(is_active):
	active = is_active
	
	if sprite_node == null:
		return
	if active:
		sprite_node.play("awake")
	else:
		sprite_node.play("asleep")
