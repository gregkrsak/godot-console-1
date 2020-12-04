# Copyright © 2020 Mansur Isaev and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.

extends Reference


var _commands : PoolStringArray
var _prev_string : String


func set_commands(commands: Array) -> void:
	_commands = PoolStringArray(commands)
	return


func get_string(text: String) -> String:
	for string in _commands:
		if string.begins_with(text) and string != _prev_string:
			_prev_string = string
			return string
	
	return text
