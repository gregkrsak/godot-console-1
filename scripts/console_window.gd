# ConsoleWindow class.
tool
extends WindowDialog


const CONSOLE_OUTPUT = preload("console_output.gd") # Include console ControlOutput.
const CONSOLE_INPUT = preload("console_input.gd") # Include console ControlInput.

const DEFAULT_WINDOW_TITLE = "Console"


var _console_output : CONSOLE_OUTPUT
var _console_input  : CONSOLE_INPUT


func _init() -> void:
	self.window_title = DEFAULT_WINDOW_TITLE
	
	var vbox = VBoxContainer.new()
	vbox.set_anchors_and_margins_preset(Control.PRESET_WIDE)
	self.add_child(vbox)
	
	_console_output = CONSOLE_OUTPUT.new()
	vbox.add_child(_console_output)

	_console_input = CONSOLE_INPUT.new()
	vbox.add_child(_console_input)
	
	return
