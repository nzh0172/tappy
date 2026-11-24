extends Node

signal add_score
signal game_over

func add_score_emit() -> void:
	add_score.emit()
	
func game_over_emit() -> void:
	game_over.emit()
