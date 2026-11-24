extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fly"):
		#Switch to game scene (now with autoloaded GameManager to prevent circular references)
		GameManager.load_game_scene()
