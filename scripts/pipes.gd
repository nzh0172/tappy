extends Node2D
class_name Pipes

const SCROLL_SPEED: float = 120.0
var i : int = 0


func _process(delta: float) -> void:
	position.x -= SCROLL_SPEED * delta

# VisibleOnScreenNotifier2D: A 2D box that detects if its on screen or off screen
# NOT the VisibleOnScreenEnabler2D: A 2D box that enables or disable its target node's processing (_process,_physics_process, physics calculation)
# if its on screen or off screen

func _on_screen_exited() -> void:
	queue_free() # When pipes exit the screen, remove the pipes


# Two body_entered signals (upper and lower pipes) are routed into this one
# Make sure callback function is the same name (or click pick)

# Area2D's CollisionObject2D > Collision layer/Collision mask --> The numbers can be renamed
# 
# Simple formula:
# 	Collision layer: who am i
# 	Collision mask: what i can detect
#   
#  For example: Layer 1 (pipe) Mask 2 (frog)

func _on_pipe_body_entered(body: Node2D) -> void:
	# The pipes hitting the world boundary. To make the pipes only collide with frog, we need to set collision layers and collision masks
	
	#on_pipe_body_entered: pipes world boundary
	#on_pipe_body_entered: pipes world boundary
	#on_pipe_body_entered: pipes frog

	#print("on_pipe_body_entered: %s %s" % [name, body.name])
	
	if body is frog: # if body is of type frog (which we have the class_name frog in frog.gd)
		body.die()


# Set the signal to one-shot to avoid double score (frog retrigger on when flying on certain way)
# Signals > Edit method > Advanced > One-shot
func _on_scoring_laser_body_entered(body: Node2D) -> void:
	#print("_on_scoring_laser_body_entered: %s %s" % [name, body.name])
	
	if body is frog:
		body.score()
