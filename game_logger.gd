# Child Logger class. Create custom logic here.
extends "scripts/logger.gd"


func _ready() -> void:
	self.set_log_enabled(true) # Enable logging.
	self.set_stdout(false) # Disable engine default "print".
	self.set_file_write(true) # Enable logging to file.
	return


func _console_log_enabled(args: PoolStringArray) -> void:
	var value = int(args[0])
	self.set_file_write(value)
	return
