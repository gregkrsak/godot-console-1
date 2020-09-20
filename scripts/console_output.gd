# Console ControlOutput class.
extends RichTextLabel


const LOGGER_MESSAGE = preload("logger_message.gd")


const LEVEL = LOGGER_MESSAGE.Level
const LEVEL_COLOR = {
	LEVEL.INFO: Color.gray,
	LEVEL.DEBUG: Color.dimgray,
	LEVEL.WARNING: Color.yellow,
	LEVEL.ERROR: Color.firebrick,
	LEVEL.FATAL: Color.red,
	}

# Color for console messages.
const COLOR_CONSOLE := Color.darkorange


func _init() -> void:
	self.size_flags_vertical = SIZE_EXPAND_FILL
	self.size_flags_horizontal = SIZE_EXPAND_FILL
	self.scroll_following = true
	self.selection_enabled = true
	
	self.focus_mode = Control.FOCUS_NONE
	return


func _ready() -> void:
	Log.connect("new_message", self, "print_message")
	Console.connect("message", self, "print_line")
	return


func print_line(text: String) -> bool:
	if text.empty():
		return false
	else:
		_new_line(text, COLOR_CONSOLE)
		return true


func print_message(message: LOGGER_MESSAGE) -> void:
	_new_line(message.to_string(), LEVEL_COLOR[message.get_level()])
	return


func _new_line(text: String, color: Color) -> void:
	self.newline()
	self.push_color(color)
	self.add_text(text)
	return
