# Singletone Logger class.
extends Node


signal new_message(message)


const MESSAGE = preload("logger_message.gd")
const MESSAGE_LEVEL = MESSAGE.Level

const DEFAULT_DIR_PATH = "res://log/"
const DEFAULT_FILE_NAME = "test.log"


var _log_enabled : bool
var _stdout_enabled : bool
var _file_write_enabled : bool

var _messages : Array
var _file : File


func set_log_enabled(value: bool) -> void:
	_log_enabled = value
	return


func is_log_enabled() -> bool:
	return _log_enabled


func set_stdout(value: bool) -> void:
	_stdout_enabled = value
	return


func is_stdout() -> bool:
	return _stdout_enabled


func set_file_write(value: bool) -> void:
	if value:
		_open_file()
	else:
		_close_file()
		
	_file_write_enabled = value
	self.info("Logger: File logging - " + str(value))
	return


func is_file_write() -> bool:
	return _file_write_enabled


func _enter_tree() -> void:
	if is_file_write():
		_open_file()
	return


func _exit_tree() -> void:
	_close_file()
	return

# Create a info message.
func info(text: String) -> void:
	_create_message(text, MESSAGE_LEVEL.INFO)
	return

# Create a debug message.
func debug(text: String) -> void:
	_create_message(text, MESSAGE_LEVEL.DEBUG)
	return

# Create a warning message.
func warning(text: String) -> void:
	_create_message(text, MESSAGE_LEVEL.WARNING)
	return

# Create a error message.
func error(text: String) -> void:
	_create_message(text, MESSAGE_LEVEL.ERROR)
	return

# Create a fatal message.
func fatal(text: String) -> void:
	_create_message(text, MESSAGE_LEVEL.FATAL)
	return

# Create a new logger message.
func _create_message(text: String, level: int) -> void:
	if is_log_enabled() and not text.empty():
		var message = MESSAGE.new(text, level)
		_messages.append(message)
		emit_signal("new_message", message)
		
		if is_stdout():
			print(message.to_string())
		if is_file_write():
			_file.store_line(message.to_string())
		else:
			return
	else:
		return


func _open_file() -> void:
	var dir = Directory.new()
	if dir.open(DEFAULT_DIR_PATH) != OK:
		dir.make_dir(DEFAULT_DIR_PATH)
	
	_file = File.new()
	_file.open(DEFAULT_DIR_PATH + DEFAULT_FILE_NAME, File.WRITE_READ)
	
	return


func _close_file() -> void:
	if _file != null:
		_file.close()
	return
