extends TextureButton

const level_select_path = "res://Scenes/LevelSelect.tscn"

func _pressed():
	GameEvents.emit_signal("game_paused", false)
	get_tree().change_scene(level_select_path)
