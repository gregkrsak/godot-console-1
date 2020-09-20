# Godot-Console
Simple logger and console for Godot 3.2.

# Features
- Installed as plugin.
- Singletone Logger and Console.
- History of entered console commands.

# Installation:
1. Clone or download this project to to your addons folder.
2. Enabled `Logger & Console` in Plugins.
3. Add new action to the Input Map: `show_console`
4. Add `ConsoleWindow` node to the scene.
4. Profit.

# Usage:
## Register console command:
```gdscript
func _ready() -> void:
	var name = "level_up" # Name of the console command. Used to enter a command in the console.
	var func_ref = funcref(self, "_console_player_up") # Reference to a function in an object.
	var desc = "Level up player." # Description of the console command. May be empty.
	var arg_count = 0 # Number of arguments for the console command. The default is 0.
	# Register the command in the Console.
	Console.create_command(name, func_ref, desc, arg_count)
```

## Methods for a console command without arguments should not receive argument:
```gdscript
func _console_player_up() -> void:
	self.level_up()
	return
```

## Methods for console command with arguments receive PoolString. Arguments need cast to target type.
```gdscript
func _console_player_teleport(args: PoolStringArray) -> void:
	var x = float(args[0])
	var y = float(args[1])
	self.position = Vector2(x, y)
	return
```

## Examples:
```gdscript
# Player class.
func _ready() -> void:
	# Create a console command without arguments.
	Console.create_command("level_up", funcref(self, "_console_player_up"), "Level up player.")
	
	# Create console commands with one argument.
	Console.create_command("invisible", funcref(self, "_console_player_invisible"), "Make player invisible.", 1)
	Console.create_command("add_money", funcref(self, "_console_player_add_money"), "Add money to a player", 1)
	
	# Create a console command with two arguments.
	Console.create_command("teleport", funcref(self, "_console_player_teleport"), "Teleport player to position.", 2)
```

### Method for a console command without arguments:
```gdscript
func _console_player_up() -> void:
	self.level_up()
```

### Methods for a console commands with one argument:
```gdscript
func _console_player_invisible(args: PoolStringArray) -> void:
	var value = bool(args[0]) # Cast argument string to bool type.
	self.invisible = value
```
```gdscript
func _console_player_add_money(args: PoolStringArray) -> void:
	var value = int(args[0]) # Cast argument string to int type.
	self.money += value
```

### Method for a console command with two arguments.
```gdscript
func _console_player_teleport(args: PoolStringArray) -> void:
	var x = float(args[0]) # Cast argument string to float type.
	var y = float(args[1])
	self.position = Vector2(x, y)
```
