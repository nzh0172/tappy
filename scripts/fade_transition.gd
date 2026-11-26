extends CanvasLayer

@export var main: PackedScene
@export var game: PackedScene

var next_scene: PackedScene

@onready var animation_player: AnimationPlayer = $AnimationPlayer

'''
Simple transition (with a scene): Main menu -> Game (used onready var)
Fade transition (with black overlay): Game -> Main menu (used export var)

Transition is useful if the game needs to preload a lot of resources
'''



func load_main_scene() -> void:
	start_transition(main)
	
func to_next_scene() -> void:
	get_tree().change_scene_to_packed(next_scene)

func start_transition(_next_scene: PackedScene) -> void:
	next_scene = _next_scene
	animation_player.play("fade")
	
	
