# Singletone Console class.
extends Node


signal message(text)


const CONSOLE_COMMAND = preload("console_command.gd") # Include ConsoleCommand.
const CONSOLE_HISTORY = preload("console_history.gd") # Include ConsoleHistory.

const ERROR_EMPTY_NAME : String = "Console: Command name is empty."
const ERROR_INVALID_METHOD : String = "Console: Invalid '%s' method."
const ERROR_COMMAND_DELETE : String = "Console: Can't delete '%s', command not found."
const ERROR_COMMAND_EXISTS : String = "Console: '%s' command already exists."
const ERROR_COMMAND_NOT_FOUND : String = "Console: Command '%s', not found."

const DEFAULT_DESCRIPTION : String = "No description."


var _console_commands : Dictionary # Contains all console commands.
var _console_history : CONSOLE_HISTORY # Contains the history of input commands.


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
func create_command(name: String, method: FuncRef, desc := DEFAULT_DESCRIPTION, arg_count := 0) -> bool:
	if name.empty():
		Log.error(ERROR_EMPTY_NAME)
		return false
	elif has_command(name):
		Log.error(ERROR_COMMAND_EXISTS % name)
		return false
	else:
		if method.is_valid():
			# Create a new ConsoleCommand and add to dictionary by command name.
			_console_commands[name] = CONSOLE_COMMAND.new(name, method, desc, arg_count)
			return true
		else:
			Log.error(ERROR_INVALID_METHOD % name)
			return false

# Remove the console command by name.
func remove_command(name: String) -> bool:
	if has_command(name):
		return _console_commands.erase(name)
	else:
		Log.error(ERROR_COMMAND_DELETE % name)
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
			command.execute(args)
			return true
		else:
			Log.error(ERROR_COMMAND_NOT_FOUND % input)
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
