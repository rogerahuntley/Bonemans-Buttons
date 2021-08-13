extends TextureButton

const main_menu_path = "res://Scenes/MainMenu.tscn"

func _pressed():
	get_tree().change_scene(main_menu_path)
