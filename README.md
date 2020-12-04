# Godot-Console

Simple in-game console for Godot 3.2.

![](https://i.imgur.com/5F3aStc.png)

# Features

- Installed as plugin.
- Singletone Console.
- History of entered console commands.

# Installation:

1. Clone or download this project to `addons/godot-console` folder.
2. Enabled `Godot Console` in Plugins.
3. Add `ConsoleContainer` node to the scene.
4. Profit.

# Register console command:

```gdscript
func _ready() -> void:
	var name = "invisible" # Name of the console command. Used to enter a command in the console.
	var instance = self # Object instance.
	var funcname = "set_invisible" # Method name.
	var desc = "Set player invisible" # Command description.
	# Array of console arguments types. Only Console.BOOL, INT, FLOAT, STRING types.
	var args = [Console.BOOL] 
	
	# Register the command in the Console.
	Console.create_command(name, instance, funcname, desc, args)
```
# Usage:

## Methods for a console command without arguments:

```gdscript
func _ready() -> void:
	Console.create_command("heal", self, "_command_heal", "Command heals the player")
	return

func _command_heal() -> String:
	self.set_health(HEALTH_MAX)
	# Return a string for console output. Optional.
	return "Player is completely healed"
```

## Methods for a console command with one argument:

```gdscript
func _ready() -> void:
	Console.create_command("invisible", self, "_command_invisible", "Invisible player", [Console.BOOL])
	return

func _command_invisible(value: bool) -> String:
	self.set_invisible(value)
	return "Player invisible: %s" % is_invisible()
```

## Methods for a console command with two argument:

```gdscript
func _ready() -> void:
	Console.create_command("tp", self, "_command_teleport", "Teleports the player", [Console.FLOAT, Console.FLOAT])
	return

func _command_teleport(x: float, y: float) -> void:
	self.set_position(Vector2(x, y))
	return
```

## License

Copyright © 2020 FULL NAME and contributors

Unless otherwise specified, files in this repository are licensed under the
MIT license. See [LICENSE.md](LICENSE.md) for more information.
