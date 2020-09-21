# ConsoleCommand class.
extends Reference


const ASSERT_EMPTY_NAME = "Empty console command name."
const ASSERT_INVALID_METHOD = "Invalid 'FuncRef' in '%s' command."
const ASSERT_ARG_COUNT = "Argument count cannot be less than zero"

const WARNING_ARG_COUNT = "'%s' command must have %s arguments."

const DEFAULT_DESCRIPTION = "No description."


var _name : String
var _method : FuncRef
var _desc : String
var _arg_count : int


func _init(name: String, method: FuncRef, desc: String, arg_count: int) -> void:
	_set_name(name)
	_set_method(method)
	_set_desc(desc)
	_set_arg_count(arg_count)
	return

# Return command name.
func get_name() -> String:
	return _name

# Return command description.
func get_desc() -> String:
	return _desc

# Return command arguments count.
func get_arg_count() -> int:
	return _arg_count

# Return true if arguments count more than 0.
func has_arg() -> bool:
	return get_arg_count() > 0

# Execute command FuncRef.
func execute(args: PoolStringArray) -> void:
	var command_name : String = args[0] # First word in args is the command name.
	
	if has_arg():
		args.remove(0) # Remove command name from arguments.
		# Warning if there are fewer arguments than necessary.
		if args.size() < get_arg_count():
			Log.warning(WARNING_ARG_COUNT % [command_name, get_arg_count()])
			return
		else: # Call a function with arguments.
			_method.call_func(args)
			return
	else: # Call a function without arguments.
		_method.call_func()
		return


func _set_name(name: String) -> void:
	assert(not name.empty(), ASSERT_EMPTY_NAME)
	_name = name
	return


func _set_method(method: FuncRef) -> void:
	assert(method.is_valid(), ASSERT_INVALID_METHOD % get_name())
	_method = method
	return


func _set_desc(desc: String) -> void:
	if desc.empty():
		_desc = DEFAULT_DESCRIPTION
	else:
		_desc = desc
	return


func _set_arg_count(args_count: int) -> void:
	assert(args_count >= 0, ASSERT_ARG_COUNT)
	_arg_count = args_count
	return
