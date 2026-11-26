extends Node

# ScoreManager is also an autoload

var _score : int = 0
var high_score: int = 0:
	set(value):
		if value > high_score:
			high_score = value # BUG: high_score = _score made high_score 0 even though the file correctly saved the hiscore as _score = 0

func add_score() -> void:
	_score += 1
	SignalHub.add_score_emit(_score)
	
func reset_score() -> void:
	_score = 0
	

#######

func _ready() -> void:
	SignalHub.game_over.connect(on_game_over)
	load_from_file()
	
func on_game_over() -> void:
	high_score = _score
	save_to_file()
	reset_score()
	 
######## SAVE SCORE (FILEACCESS code from Godot docs)
# Uses alias address to save data (user://), do not save data in project folder (res://)
# Project > Open User Data Folder to see where the data is being stored for the game
# store_8, store_16, store_32, store_64
	
const SAVE_PATH = "user://save_game.dat"

func save_to_file():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if !file:
		push_error("file not found")
		return
	file.store_32(high_score) # Store 32 bits (integer) in Lendian (little endian) binary format

func load_from_file():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if !file:
		push_error("file not found")
		return
	high_score = file.get_32() # Read 32 bits (integer) in Lendian (little endian) binary format

	
