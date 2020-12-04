# Copyright © 2020 Mansur Isaev and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.

# Base class for arguments.
class argType extends Reference:
	static func get_name() -> String:
		return str(null)
	
	static func is_valid(string: String) -> bool:
		return false
	
	static func convert_string(string: String):
		return null

# Boolean argument type.
class argBool extends argType:
	const TRUE  = "true"
	const FALSE = "false"
	
	static func get_name() -> String:
		return "bool"
	
	static func is_valid(string: String) -> bool:
		if string == TRUE or string == FALSE:
			return true
		
		return string.is_valid_integer()
	
	static func convert_string(string: String) -> bool:
		if string == TRUE:
			return true
		
		if string == FALSE:
			return false
		
		return convert(string, TYPE_INT) > 0

# Integer argument type.
class argInt extends argType:
	static func get_name() -> String:
		return "int"
	
	static func is_valid(string: String) -> bool:
		return string.is_valid_integer()
	
	static func convert_string(string: String) -> int:
		return convert(string, TYPE_INT)

# Float argument type.
class argFloat extends argType:
	static func get_name() -> String:
		return "float"
	
	static func is_valid(string: String) -> bool:
		return string.is_valid_float()
	
	static func convert_string(string: String) -> float:
		return convert(string, TYPE_REAL)

# String argument type.
class argString extends argType:
	static func get_name() -> String:
			return "string"
	
	static func is_valid(string: String) -> bool:
		return true
	
	static func convert_string(string: String) -> String:
		return string
