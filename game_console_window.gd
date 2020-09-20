tool
class_name ConsoleWindow, "res://addons/godot-console/icons/console_window.svg"
extends "scripts/console_window.gd"


func _init() -> void:
	return


func _input(event: InputEvent) -> void:
	if event.is_action("show_console"):
		self.popup_centered()
	return
