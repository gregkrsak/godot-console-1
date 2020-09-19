#tool
class_name ConsoleControl
extends VBoxContainer


const CONSOLE_OUTPUT = preload("console_control_output.gd")
const CONSOLE_INPUT = preload("console_control_input.gd")


var _console_output : CONSOLE_OUTPUT
var _console_input  : CONSOLE_INPUT


func _init() -> void:
	_console_output = CONSOLE_OUTPUT.new()
	self.add_child(_console_output)
	
	_console_input = CONSOLE_INPUT.new()
	self.add_child(_console_input)
	
	return
