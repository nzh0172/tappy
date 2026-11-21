extends CharacterBody2D

const FLY_FORCE: float = -350
var _gravity: float = ProjectSettings.get_setting('physics/2d/default_gravity') # Get project settings


# move_and_slide() no need delta except gravity 
# If need acceleration (gravity), multiply by delta
#
# From the docs:
# move_and_slide() automatically includes the timestep in its calculation, 
# so you should not multiply the velocity vector by delta. 
# This does not apply to gravity as it is an acceleration and is time dependent, and needs to be scaled by delta.

func _physics_process(delta: float) -> void:
	velocity.y += _gravity * delta
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fly"):
		velocity.y = FLY_FORCE
	
