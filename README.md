# Godot-Console
Simple logger and console for Godot 3.2.

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

# Usage:
## Methods for a console command without arguments:
```gdscript
func _ready() -> void:
	Console.create_command("heal", self, "_command_heal", "Command heals the player")
```
```gdscript
func _command_heal() -> String:
	self.set_health(HEALTH_MAX)
	# Return a string for console output. Optional.
	return "Player is completely healed"
```

## Methods for a console command with one argument:
```gdscript
func _ready() -> void:
	Console.create_command("invisible", self, "_command_invisible", "Invisible player", [Console.BOOL])
```
```gdscript
func _command_invisible(value: bool) -> String:
	self.set_invisible(value)
	return "Player invisible: %s" % is_invisible()
```

## Methods for a console command with two argument:
```gdscript
func _ready() -> void:
	Console.create_command("tp", self, "_command_teleport", "Teleports the player", [Console.FLOAT, Console.FLOAT])	
```
```gdscript
func _command_teleport(x: float, y: float) -> void:
	self.set_position(Vector2(x, y))
	return
```
