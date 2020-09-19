#Console History class.
extends Reference


var _history : Array
var _index : int


func add_history(input: String) -> bool:
	if input.empty():
		return false
	else:
		_history.append(input)
		_index = _history.size()
#		_history.push_front(input)
		print(_history.size())
		return true


func set_index(index: int) -> void:
	if index < 0:
		_index = 0
	elif index > _history.size() - 1:
		_index = _history.size() - 1
	else:
		_index = index
	
	print(_index)
	return


func get_index() -> int:
	return _index


func get_prev() -> String:
	set_index(_index - 1)
	return get_history(_index)


func get_next() -> String:
	set_index(_index + 1)
	return get_history(_index)


func get_history(index: int) -> String:
	if index < 0:
		return _history.pop_front()
	elif index > _history.size():
		return _history.pop_back()
	else:
		return _history[index]
