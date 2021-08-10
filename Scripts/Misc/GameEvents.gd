extends Node

signal level_changed(level_name)
signal level_reset()
signal event_triggered(event_code, event_state)
signal menu_opened(menu_name)
signal menu_closed(menu_name)
signal speed_changed(new_speed)
signal game_paused(pause_state)
signal player_moved()
signal player_killed()
