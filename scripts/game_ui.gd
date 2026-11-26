extends Control

@onready var highscore_label: Label = $"MarginContainer/highscore label"
@onready var game_over_label: Label = $"MarginContainer/game over label"
@onready var press_jump_label: Label = $"MarginContainer/press jump label"
@onready var jump_label_timer: Timer = $"jump label timer"
@onready var game_over_sound: AudioStreamPlayer = $"game over sound"

# Signal hub is a design pattern that centralize signal connections into one
# similar to Autoloaded game manager, it is global throughout the project.
# Prevents direct dependencies between scenes' signal emitter and receiver, 
# similar to how GameManager centralized scene navigation
# The receiver scene doesn't need to know who the emitter scene is

func _ready() -> void:
	SignalHub.add_score.connect(ui_add_score)
	SignalHub.game_over.connect(ui_game_over)

# The function parameter MUST match the signal's parameter (if signal use param)
func ui_add_score(score: int) -> void:
	highscore_label.text = "%04d" % score
	
func ui_game_over() -> void:
	game_over_label.show()
	game_over_sound.play()
	jump_label_timer.start()

# GameUI Control node > Process is set to Always
# As the whole game tree paused, unable to receive input, so must set process to always

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("main menu"):
		# No need to do var manager = GameManager.new() and reference
		# GameManager (autoload/global) is readily available
		# All scenes are preloaded now on GameManager.
		GameManager.load_main_scene()
	if jump_label_timer.is_stopped() and press_jump_label.is_visible() and event.is_action_pressed("fly"):
		GameManager.load_main_scene()

func _on_jump_label_timer_timeout() -> void:
	game_over_label.hide()
	press_jump_label.show()
	
'''
Godot process input in top-down order (cascading/propagete): _input -> _on_gui_input -> _unhandled_input

If input can be handled by _input() then ok. if not it will pass to _on_gui_input() to handle it. Else it will be handled by _unhandled_input().

Why need to handle input?
- A character moves, and you pause. Can interact with pause UI but you can still control the character movement. So we need to block it so that we only interact with the pause UI, hence being handled

Why _input() + left click works but not _unhandled_input() +left click?
go to a Control node (Game UI) > Inspector > Control > Mouse > Filter

Filter is set to stop which means that the left click will be filtered to stop and be handled by _input() and no one can handle it below _input()
to make _unhandled_input() + left click work, need to set Filter to Ignore

Mouse Filter: 
Stop - Stops the event from propagating to parent Controls and prevents it from reaching unhandled input processing.
Pass - Allows the event to propagate to parent Controls.
Ignore- The Control ignores mouse events and doesn't block other Controls from receiving them.

'''
