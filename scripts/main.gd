extends Control

var GAME = load("uid://7fngfmfwj2cj")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fly"):
		#Switch to game scene
		get_tree().change_scene_to_packed(GAME) 
