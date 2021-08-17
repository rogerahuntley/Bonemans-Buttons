extends Node

signal level_changed(level_name)
signal level_completed(level_name)
signal level_reset()
signal event_triggered(event_code, event_state)
signal menu_opened(menu_name)
signal menu_closed(menu_name)
signal speed_changed(new_speed)
signal game_paused(pause_state)
signal player_moved()
signal player_killed()

var level_select_scene = "res://Scenes/LevelSelect.tscn"
var main_menu_scene = "res://Scenes/MainMenu.tscn"
var game_handler_scene = "res://Scenes/GameHandler.tscn"

func launch_level_select():
	change_scene(level_select_scene)
	
func launch_game_handler():
	change_scene(game_handler_scene)
	
func launch_main_menu():
	change_scene(main_menu_scene)

func change_scene(scene):
	get_tree().change_scene(scene)
