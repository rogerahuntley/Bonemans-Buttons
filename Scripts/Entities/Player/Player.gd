extends Entity

class_name Player

onready var swipe_node = $Swipe
onready var camera_node = $PlayerCamera as PlayerCamera
var can_move = true

var directions_stack = []

func check_keys():
	if Input.is_action_just_pressed("ui_up"):
		directions_stack.push_back(Direction.Up)
	if Input.is_action_just_released("ui_up"):
		directions_stack.erase(Direction.Up)
		
	if Input.is_action_just_pressed("ui_right"):
		directions_stack.push_back(Direction.Right)
	if Input.is_action_just_released("ui_right"):
		directions_stack.erase(Direction.Right)
		
	if Input.is_action_just_pressed("ui_down"):
		directions_stack.push_back(Direction.Down)
	if Input.is_action_just_released("ui_down"):
		directions_stack.erase(Direction.Down)
		
	if Input.is_action_just_pressed("ui_left"):
		directions_stack.push_back(Direction.Left)
	if Input.is_action_just_released("ui_left"):
		directions_stack.erase(Direction.Left)

func plan_move():
	if can_move && alive:
		#check if swipe
		var swipe = swipe_node.get_swipe_dir()
		
		if swipe != null:
			if swipe == swipe_node.Direction.Up:
				plan_move_in_direction(DirectionVector[Direction.Up])
			elif swipe == swipe_node.Direction.Right:
				plan_move_in_direction(DirectionVector[Direction.Right])
			elif swipe == swipe_node.Direction.Down:
				plan_move_in_direction(DirectionVector[Direction.Down])
			elif swipe == swipe_node.Direction.Left:
				plan_move_in_direction(DirectionVector[Direction.Left])
		else:
			if Input.is_action_pressed("ui_up") && directions_stack.back() == Direction.Up:
				plan_move_in_direction(DirectionVector[Direction.Up])
			elif Input.is_action_pressed("ui_right") && directions_stack.back() == Direction.Right:
				plan_move_in_direction(DirectionVector[Direction.Right])
			elif Input.is_action_pressed("ui_down") && directions_stack.back() == Direction.Down:
				plan_move_in_direction(DirectionVector[Direction.Down])
			elif Input.is_action_pressed("ui_left") && directions_stack.back() == Direction.Left:
				plan_move_in_direction(DirectionVector[Direction.Left])

func plan_update():
	check_keys()
	plan_move()

func update():
	if move():
		can_move = false
		GameGlobals.tween_node.interpolate_callback(self, 1.3, "done_moving")
		GameGlobals.tween_node.interpolate_callback(self, 1, "done_signal")

func done_moving():
	can_move = true

func done_signal():
	GameEvents.emit_signal("player_moved")

func die():
	GameEvents.emit_signal("player_killed")
	sprite_node.queue_free()
