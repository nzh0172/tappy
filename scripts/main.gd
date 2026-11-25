extends Control

@onready var highscore_num: Label = $"MarginContainer2/highscore num"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fly"):
		#Switch to game scene (now with autoloaded GameManager to prevent circular references)
		GameManager.load_game_scene()

func _ready() -> void:
	get_tree().paused = false
	highscore_num.text = "%04d" % ScoreManager.high_score
