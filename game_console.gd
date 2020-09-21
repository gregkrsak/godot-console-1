# Child Console class. Create custom logic here.
extends "scripts/console.gd"


func _ready() -> void:
	# Create command for self:
	create_command("help", funcref(self, "_console_help"), "Write all avaible command.")
	create_command("version", funcref(self, "_console_version"), "Show Engine version.")
	create_command("test", funcref(self, "_console_test"), "Test console output.")
	create_command("print", funcref(self, "_console_print"), "Print any string to console.", 1)
	create_command("add", funcref(self, "_console_add"), "Adds two numbers.", 2)
	create_command("subtract", funcref(self, "_console_subtract"), "Subtract two number", 2)
	create_command("multiply", funcref(self, "_console_multiply"), "Multiply two number.", 2)
	create_command("divide", funcref(self, "_console_divide"), "Divide two number.", 2)
	create_command("quit", funcref(self, "_console_quit"), "Quit from game.")
	# Create command for another object:
	create_command("log_enabled", funcref(Log, "_console_log_enabled"), "Set logging to file.", 1)
	return

# Print all console commands to the console.
func _console_help() -> void:
	var string : String
	
	for command in self._get_commands():
		string = command .get_name() + "- " + command .get_desc()
		self.print_line(string)
	
	return

# Print test messages to logger and console.
func _console_test() -> void:
	var string := "Quick brown fox jumps over the lazy dog."
	Log.info(string)
	Log.debug(string)
	Log.warning(string)
	Log.error(string)
	Log.fatal(string)
	self.print_line(string)
	return

# Print engine version to the console.
func _console_version() -> void:
	var string = "Godot Engine {major}.{minor}.{patch}".format(Engine.get_version_info())
	self.print_line(string)
	return

# Print any text to the console.
func _console_print(args: PoolStringArray) -> void:
	var string = "Print: %s" % args[0]
	self.print_line(string)
	return

# Add two numbers and print the result to the console.
func _console_add(args: PoolStringArray) -> void:
	var a = float(args[0])
	var b = float(args[1])
	self.print_line("Add: %s" % [a + b])
	return

# Subtract two numbers and print the result to the console.
func _console_subtract(args: PoolStringArray) -> void:
	var a = float(args[0])
	var b = float(args[1])
	self.print_line("Subtract: %s" % [a - b])
	return

# Multiply two numbers and print the result to the console.
func _console_multiply(args: PoolStringArray) -> void:
	var a = float(args[0])
	var b = float(args[1])
	self.print_line("Multiply: %s" % [a * b])
	return

# Divide two numbers and print the result to the console.
func _console_divide(args: PoolStringArray) -> void:
	var a = float(args[0])
	var b = float(args[1])
	if b == 0:
		Log.error("Division by zero.")
		return
	else:
		self.print_line("Aivide: %s" % [a / b])
		return

# Quit the game.
func _console_quit() -> void:
	get_tree().quit()
	return
