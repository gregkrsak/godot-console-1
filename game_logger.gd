# Child Logger class.
extends "scripts/logger.gd"


func _ready() -> void:
	set_log_enabled(true)
	set_stdout(false)
	set_file_write(true)
	return
