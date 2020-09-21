# Console output control class. Output console messages.
extends RichTextLabel


const LOGGER_MESSAGE = preload("logger_message.gd") # Include LoggerMessage.

const LEVEL = LOGGER_MESSAGE.Level
const LEVEL_COLOR = {
	LEVEL.INFO: Color.gray,
	LEVEL.DEBUG: Color.dimgray,
	LEVEL.WARNING: Color.yellow,
	LEVEL.ERROR: Color.red,
	LEVEL.FATAL: Color.red,
	}

const COLOR_CONSOLE := Color.darkorange # Color for console messages.


func _init() -> void:
	self.size_flags_vertical = SIZE_EXPAND_FILL
	self.size_flags_horizontal = SIZE_EXPAND_FILL
	self.scroll_following = true
	self.selection_enabled = true
	self.rect_min_size = Vector2(128, 128)
	self.focus_mode = Control.FOCUS_NONE
	return


func _ready() -> void:
	Log.connect("new_message", self, "print_message")
	Console.connect("message", self, "print_line")
	return

# Print any text to console.
func print_line(text: String) -> bool:
	if text.empty():
		return false
	else:
		_new_line(text, COLOR_CONSOLE)
		return true

# Print logger message to console.
func print_message(message: LOGGER_MESSAGE) -> void:
	var text = message.to_string()
	var color = LEVEL_COLOR[message.get_level()]
	_new_line(text, color)
	return


func _new_line(text: String, color: Color = COLOR_CONSOLE) -> void:
	self.newline()
	self.push_color(color)
	self.add_text(text)
	return
