extends Node
# Autoload: Useful for scene switching, saving settings and scores
# Also to fix scene circular reference (menu <-> game)
# To set an autoload: Project Settings > Globals > Autoload > Create Scene/Script or Select Scene/Script


var lives = 3
var next_scene: PackedScene

const MAIN = preload("uid://8yhyev0gaydb")
const GAME = preload("uid://7fngfmfwj2cj")
const SIMPLE_TRANSITION = preload("uid://tmn3s7sk1ojl")

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

	

'''
GameManager's functions and variables is readily available with no references to anything at all.  
No need to create new instance of GameManager on game.gd like var a = GameManager.new()

Now we can preload all scene in the GameManager

To fix circular scene navigation reference: Autoload

Main menu scene goes to game scene, and game scene goes to main menu scene. This is called circular reference (they referenced each other).

For 1st time, menu to preload game works but when 2nd time, going from game to menu doesnt work and produce this error:

Failed to instantiate scene state of "", node count is 0. Make sure the PackedScene resource is valid.
Parameter "new_scene" is null.
  <C++ Source>  scene/main/scene_tree.cpp:1717 @ change_scene_to_packed()
  <Stack Trace> game.gd:29 @ _unhandled_input()

Singleton: a single instance of class that runs during the entire application lifetime.

Autoload is kinda a singleton. In Godot docs it said that it is a singleton but it is not since you can create multiple instances of it (singleton = only one instance)

Autoload/Global can be used to share information between different scenes and data like game settings, scores etc

We set all our scenes to load in a autoload/global called GameManager. In here it manages scene switching.

When run it will create a node (GameManager) under the game scene tree.

To set an autoload: Project Settings > Globals > Autoload > Create Scene/Script or Select Scene/Script

Create a new folder called globals

'''
