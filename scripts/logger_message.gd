# Logger Message class.
extends Reference

# Levels for message.
enum Level {
	INFO = 0,
	DEBUG = 1,
	WARNING = 1 << 1,
	ERROR = 1 << 2,
	FATAL = 1 << 3,
	}


var _level : int
var _text : String

var _hour : int
var _minute : int
var _second : int


func _init(text: String, level: int = Level.INFO, time: Dictionary = OS.get_time()) -> void:
	_text = text
	_level = level
	
	_hour = time.hour
	_minute = time.minute
	_second = time.second
	return


func _to_string() -> String:
	var string = "[%s:%s:%s][%s] %s"
	return string % [_hour, _minute, _second, get_level_text(), _text]


func get_level() -> int:
	return _level


func get_text() -> String:
	return _text


func get_level_text() -> String:
	var level_text : String
	match get_level():
		Level.INFO:
			level_text = "INFO"
		Level.DEBUG:
			level_text = "DEBUG"
		Level.WARNING:
			level_text = "WARNING"
		Level.ERROR:
			level_text = "ERROR"
		Level.FATAL:
			level_text = "FATAL"
	return level_text
