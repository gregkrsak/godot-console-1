# Console CommandClass.
extends Reference


const MESSAGE_ARG_COUNT : String = "'%s' command must have %s arguments."


var _name : String
var _method : FuncRef
var _desc : String
var _arg_count : int


func _init(name: String, method: FuncRef, desc: String, arg_count: int) -> void:
	_name = name
	_method = method
	_desc = desc
	_arg_count = arg_count
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
func execute_command(args: PoolStringArray) -> void:
	var command_name : String = args[0]
	var arg_count : int = get_arg_count()
	
	if has_arg():
		args.remove(0) # Remove command name from arguments.
		# Warning if there are fewer arguments than necessary.
		if args.size() < arg_count:
			Log.warning(MESSAGE_ARG_COUNT % [command_name, arg_count])
			return
		else: # Call a function with arguments.
			_method.call_func(args)
			return
	else:
		_method.call_func()
		return
