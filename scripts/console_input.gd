# Console ControlInput class.
extends LineEdit


func _init() -> void:
	self.context_menu_enabled = false
	self.clear_button_enabled = true
	self.caret_blink = true
	self.placeholder_text = "Command"
	return


func _gui_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ENTER):
		_enter_text()
	elif Input.is_key_pressed(KEY_UP):
		self.text = Console.get_prev_command()
	elif Input.is_key_pressed(KEY_DOWN):
		self.text = Console.get_next_command()
	
	return


func _enter_text() -> void:
	Console.write_line(self.text)
	self.clear()
	return
