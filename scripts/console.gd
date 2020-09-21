# Singletone Console class.
extends Node


signal message(text)


const CONSOLE_COMMAND = preload("console_command.gd") # Include ConsoleCommand.
const CONSOLE_HISTORY = preload("console_history.gd") # Include ConsoleHistory.

const ASSERT_COMMAND_EXISTS = "Console command '%s' already exists."

const WARNING_COMMAND_NOT_FOUND = "Console: Command '%s', not found."


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
func create_command(name: String, method: FuncRef, desc : String = "", arg_count := 0) -> void:
	assert(not has_command(name), ASSERT_COMMAND_EXISTS % name)
	_console_commands[name] = CONSOLE_COMMAND.new(name, method, desc, arg_count)
	return

# Remove the console command by name.
func remove_command(name: String) -> bool:
	assert(not has_command(name), ASSERT_COMMAND_EXISTS % name)
	return _console_commands.erase(name)

# Enter console command.
func write_line(input: String) -> bool:
	if input.empty():
		return false
	else:
		_console_history.add_history(input) # Add input string to history.
		
		var args : PoolStringArray = input.split(" ", false) # Split input string by spaces.
		var name : String = args[0] # First word in input a command name.
		var command : CONSOLE_COMMAND = get_command(name) # Get command or null by name.
		
		self.print_line("-> " + name) # Print in console command name.
		
		# Execute command if command not null.
		if command != null:
			command.execute(args)
			return true
		else:
			Log.warning(WARNING_COMMAND_NOT_FOUND % input)
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
