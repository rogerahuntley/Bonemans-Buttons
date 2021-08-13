extends TextureButton

const game_path = "res://Scenes/GameHandler.tscn"

func _pressed():
	get_tree().change_scene(game_path)
