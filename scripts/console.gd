#tool
#class_name iConsole
extends Node


signal message(text)


const CONSOLE_COMMAND = preload("console_command.gd")
const CONSOLE_HISTORY = preload("console_history.gd")


var _console_commands : Dictionary # Contains all console commands.
var _console_history : CONSOLE_HISTORY # Contains all the input console commands.


func _init() -> void:
	_console_history = CONSOLE_HISTORY.new()
	return

# Return true if contains a console command with the same name.
func has_command(name: String) -> bool:
	return _console_commands.has(name)

# Return command or null.
func get_command(name: String) -> CONSOLE_COMMAND:
	if has_command(name):
		return _console_commands[name]
	else:
		return null

# Create a new console command.
func create_command(name: String, method: FuncRef, desc: String = "No description.", arg_count: int = 0) -> bool:
	if name.empty():
		Log.error("Console: Command name is empty.")
		return false
	elif has_command(name):
		Log.error("Console: '%s' command already exists." % name)
		return false
	else:
		if method.is_valid():
			_console_commands[name] = CONSOLE_COMMAND.new(name, method, desc, arg_count)
			return true
		else:
			Log.error("Console: Invalid '%s' method." % name)
			return false

# Remove the console command by name.
func remove_command(name: String) -> bool:
	if has_command(name):
		return _console_commands.erase(name)
	else:
		Log.error("Console: Can't delete '%s', command not found." % name)
		return false

# Enter console command.
func write_line(input: String) -> bool:
	if input.empty():
		return false
	else:
		_console_history.add_history(input) # Add input string to history.
		
		var args : PoolStringArray = input.split(" ", false) # Split input string by spaces.
		var name : String = args[0] # First word in input string must be a command name.
		var command : CONSOLE_COMMAND = get_command(name) # Get command or null by name.
		
		self.print_line("-> " + name) # Print in console command name.
		
		# Execute command if command not null.
		if command != null:
			command.execute_command(args)
			return true
		else:
			Log.error("Console: Command '%s', not found." % input)
			return false

# Print text to console.
func print_line(input: String) -> bool:
	if input.empty():
		return false
	else:
		emit_signal("message", input)
		return true

# Return the previus console command.
func get_prev_command() -> String:
	return _console_history.get_prev()

# Return the next console command.
func get_next_command() -> String:
	return _console_history.get_next()

# Returns an array of all console commands.
func _get_commands() -> Array:
	return _console_commands.values()
