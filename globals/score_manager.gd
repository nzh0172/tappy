extends Node

# ScoreManager is also an autoload

var _score : int = 0
var high_score: int = 0:
	set(value):
		if value > high_score:
			high_score = _score

func add_score() -> void:
	_score += 1
	SignalHub.add_score_emit(_score)
	
func reset_score() -> void:
	_score = 0
	

#######

func _ready() -> void:
	SignalHub.game_over.connect(on_game_over)
	
func on_game_over() -> void:
	high_score = _score
	reset_score()
