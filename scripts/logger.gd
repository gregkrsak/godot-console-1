#Logger class.
extends Node


signal new_message(message)


const MESSAGE = preload("logger_message.gd")
const MESSAGE_LEVEL = MESSAGE.Level

#const LEVEL_NAME = {
#	Level.INFO: "INFO",
#	Level.DEBUG: "DEBUG",
#	Level.WARNING: "WARNING",
#	Level.ERROR: "ERROR",
#	Level.FATAL: "FATAL",
#	}

const MAX_MESSAGES_COUNT : int = 1024
const DEFAULT_FILE_PATH : String = "res://log/test.log"


var _log_enabled : bool
var _stdout_enabled : bool
var _file_write_enabled : bool

#var _message : Message
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
	_file_write_enabled = value
	return


func is_file_write() -> bool:
	return _file_write_enabled


func _enter_tree() -> void:
	_file = File.new()
	_file.open(DEFAULT_FILE_PATH, File.WRITE_READ)
	
	if is_file_write():
		return
	else:
		return


func _exit_tree() -> void:
	_file.close()
	if _file.is_open():
		_file.close()
		return
	else:
		return


func info(text: String) -> void:
	create_message(text, MESSAGE_LEVEL.INFO)
	return


func debug(text: String) -> void:
	create_message(text, MESSAGE_LEVEL.DEBUG)
	return


func warning(text: String) -> void:
	create_message(text, MESSAGE_LEVEL.WARNING)
	return


func error(text: String) -> void:
	create_message(text, MESSAGE_LEVEL.ERROR)
	return


func fatal(text: String) -> void:
	create_message(text, MESSAGE_LEVEL.FATAL)
	return


func create_message(text: String, level: int = MESSAGE_LEVEL.Level.INFO) -> void:
	if is_log_enabled() and !text.empty():
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
