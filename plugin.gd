tool
extends EditorPlugin


const AUTOLOAD_NAME_LOGGER : String = "Log" # Name of logger singletone.
const AUTOLOAD_NAME_CONSOLE : String = "Console" # Name of console singletone.

# Path to logger script file.
const AUTOLOAD_PATH_LOGGER = "res://addons/godot-console/game_logger.gd"
# Path to console script file.
const AUTOLOAD_PATH_CONSOLE = "res://addons/godot-console/game_console.gd"


func _enter_tree() -> void:
	add_autoload_singleton(AUTOLOAD_NAME_LOGGER, AUTOLOAD_PATH_LOGGER)
	add_autoload_singleton(AUTOLOAD_NAME_CONSOLE, AUTOLOAD_PATH_CONSOLE)
	return


func _exit_tree() -> void:
	remove_autoload_singleton(AUTOLOAD_NAME_LOGGER)
	remove_autoload_singleton(AUTOLOAD_NAME_CONSOLE)
	return
