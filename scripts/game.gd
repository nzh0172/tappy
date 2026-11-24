extends Node

# Use Marker2D in the world to spawn our pipes
@onready var upper_spawn: Marker2D = $"upper spawn marker"
@onready var lower_spawn: Marker2D = $"lower spawn marker"
@onready var pipes_spawner: Node2D = $"pipes spawner"

@export var pipes: PackedScene

func spawn_pipes() -> void:
	var new_pipes: Pipes = pipes.instantiate()
	var pipe_y: float = randf_range(lower_spawn.position.y, upper_spawn.position.y)
	
	new_pipes.position = Vector2(upper_spawn.position.x, pipe_y)
	# This is same as:
	#	new_pipes.position.x = upper_spawn.position.x
	#	new_pipes.position.y = pipe_y
	
	pipes_spawner.add_child(new_pipes)

func _on_spawn_timer_timeout() -> void:
	spawn_pipes()
	
# Press key to main menu is now handled by game_ui
		
# Use CanvasLayer node to separate the UI from the game
# UI (screen space/viewport), game (world space)
# Canvas items must be setup like this, if not the game UI breaks because canvas items have no screen to anchor to since the world is infinite.
"""
Game (plain Node, not Node2D/3D)
└ game nodes (character, collision, timer, etc) -- these are drawn in world space
└ Canvas Layer node                             -- these are drawn in screen space
     └ Game UI (Control node)
"""
