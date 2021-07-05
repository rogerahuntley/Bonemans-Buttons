extends Area2D

class_name EventButton

export(int, 1, 99) var trigger_id = 1

func _on_Goal_area_entered(entity: Entity):
	entity.tween_node.interpolate_callback(self, 1.1, "event_triggered")
	entity.tween_node.start()

func event_triggered():
	GameEvents.emit_signal("event_triggered", trigger_id)

func update():
	.update()

func check_attack():
	pass
