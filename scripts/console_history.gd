# ConsoleHistory class.
extends Reference


var _history : Array
var _history_index : int # Used to iterate over history.

# Add a string to the history.
func add_history(input: String) -> bool:
	if input.empty():
		return false
	else:
		_history.append(input)
		_history_index = _history.size()
		return true


func set_index(index: int) -> void:
	if index < 0:
		_history_index = _history.size() - 1
	elif index > _history.size() - 1:
		_history_index = 0
	else:
		_history_index = index
	return


func get_index() -> int:
	return _history_index

# Get the previous string from history.
func get_prev() -> String:
	set_index(get_index() - 1)
	return get_history(get_index())

# Get the next string from history.
func get_next() -> String:
	set_index(get_index() + 1)
	return get_history(get_index())

# Get history string by index.
func get_history(index: int) -> String:
	if _history.empty():
		return ""
	else:
		if index < 0:
			return _history.pop_front()
		elif index > _history.size() - 1:
			return _history.pop_back()
		else:
			return _history[index]
