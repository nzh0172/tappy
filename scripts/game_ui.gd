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
