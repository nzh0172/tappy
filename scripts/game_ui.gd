extends Control

@onready var highscore_label: Label = $"MarginContainer/highscore label"
@onready var game_over_label: Label = $"MarginContainer/game over label"

func _on_frog_add_score() -> void:
	highscore_label.text = "%04d" % GameManager.score

func _on_frog_game_over() -> void:
	game_over_label.show()
