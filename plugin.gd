tool
extends EditorPlugin


const AUTOLOAD_NAME_LOGGER : String = "Log" # Name of Logger singletone.
const AUTOLOAD_NAME_CONSOLE : String = "Console" # Name of Console singletone.

# Path to logger script file.
const SCRIPT_PATH_LOGGER  = "res://addons/godot-console/game_logger.gd"
# Path to console script file.
const SCRIPT_PATH_CONSOLE = "res://addons/godot-console/game_console.gd"

const CONSOLE_WINDOW_NAME = "ConsoleWindow"
const CONSOLE_WINDOW_SCRIPT = preload("res://addons/godot-console/game_console_window.gd")
const CONSOLE_WINDOW_ICON = preload("res://addons/godot-console/icons/console_window.svg")


func _enter_tree() -> void:
	add_autoload_singleton(AUTOLOAD_NAME_LOGGER, SCRIPT_PATH_LOGGER)
	add_autoload_singleton(AUTOLOAD_NAME_CONSOLE, SCRIPT_PATH_CONSOLE)
	
	add_custom_type(CONSOLE_WINDOW_NAME, "WindowDialog", CONSOLE_WINDOW_SCRIPT, CONSOLE_WINDOW_ICON)
	return


func _exit_tree() -> void:
	remove_autoload_singleton(AUTOLOAD_NAME_LOGGER)
	remove_autoload_singleton(AUTOLOAD_NAME_CONSOLE)
	
	remove_custom_type(CONSOLE_WINDOW_NAME)
	return
