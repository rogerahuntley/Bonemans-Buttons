extends NPEntity

class_name ChessEntity

export(Entity.Direction) var current_direction

export(bool) onready var active setget set_active
export(String) var activate_trigger = ""
var targeted = false

var target_entity

func _ready():
	set_active(active)

func plan_update():
	target_tile = null
	if active:
		target_entity = check_attack()
		plan_move()

func update():
	if active && targeted == false:
		if !target_entity:
			move()
		else:
			if target_entity && "targeted" in target_entity:
				target_entity.targeted = true
			attack_target(target_entity)
			target_entity = null
	targeted = false

func plan_move():
	if DirectionVector.has(current_direction):
		plan_move_in_direction(DirectionVector[current_direction])

func on_event_triggered(trigger_name, trigger_state):
	if trigger_name == activate_trigger:
		if trigger_state:
			set_appearance(trigger_state)
		GameGlobals.tween_node.interpolate_callback(self, 0, "set_active", trigger_state)

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
			if !entity.get_groups().has("Pushable"):
				if entity.current_tile == check_spot:
					return entity

func attack_target(target: Entity):
	move_to((target.current_tile + Vector2(.5, .5)) * target.tile_size)
	GameGlobals.tween_node.interpolate_callback(target, 1, "die")
	GameGlobals.tween_node.start()

### setters / getters

func set_active(is_active):
	active = is_active
	
	if sprite_node:
		set_appearance(is_active)


func set_appearance(is_active):
	if is_active:
		sprite_node.play("awake")
	else:
		sprite_node.play("asleep")
