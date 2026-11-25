extends Node

# Signals can also receive parameter
signal add_score(score: int)
signal game_over

# Must match signal param and function param
func add_score_emit(score: int) -> void:
	add_score.emit(score)
	
func game_over_emit() -> void:
	game_over.emit()
