extends Area2D

class_name Goal

onready var level_node = get_node("/root/Main/ViewportContainer/Viewport/Level")

export var level_name: String

func _on_Goal_area_entered(player: Player):
	player.tween_node.interpolate_callback(self, 1, "change_level")
	player.tween_node.start()

func change_level():
	GameEvents.emit_signal("level_changed", level_name)

func update():
	.update()

func check_attack():
	#assuming down
	#var left_square = 
	pass
