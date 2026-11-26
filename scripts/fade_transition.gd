extends CanvasLayer

@export var main: PackedScene
@export var game: PackedScene

var next_scene: PackedScene

const MAIN = preload("uid://8yhyev0gaydb")
const GAME = preload("uid://7fngfmfwj2cj")
const SIMPLE_TRANSITION = preload("uid://tmn3s7sk1ojl")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

'''
Simple transition (with a scene): Main menu -> Game
Fade transition (with black overlay): Game -> Main menu

Transition is useful if the game needs to preload a lot of resources
'''

func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)

func load_game_scene() -> void:
	get_tree().change_scene_to_packed(SIMPLE_TRANSITION)
	next_scene = GAME
	
func to_next_scene() -> void:
	get_tree().change_scene_to_packed(next_scene)

	
