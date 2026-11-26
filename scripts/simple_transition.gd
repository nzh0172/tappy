extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Await a signal: Wait until the timer ends and emit its signal
	# Non-blocking, the code will pause here while the application is running
	await get_tree().create_timer(1.0).timeout # a scene tree's temporary timer
	GameManager.to_next_scene()
