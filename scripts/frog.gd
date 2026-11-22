extends CharacterBody2D

class_name frog

const FLY_FORCE: float = -350
var _gravity: float = ProjectSettings.get_setting('physics/2d/default_gravity') # Get project settings
#var _die: bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# move_and_slide() no need delta except gravity 
# If need acceleration (gravity), multiply by delta
#
# From the docs:
# move_and_slide() automatically includes the timestep in its calculation, 
# so you should not multiply the velocity vector by delta. 
# This does not apply to gravity as it is an acceleration and is time dependent, and needs to be scaled by delta.



# CharacterBody2D movement methods: bool is_on_floor(), is_on_ceiling(), is_on_wall() 
# How does it know which is floor and ceiling? (read docs)
#
#- The UP_DIRECTION vector and MAX_ANGLE of the frog
#- UP_DIRECTION is a vector that is always pointed up
#- MAX_ANGLE for slopes

func _physics_process(delta: float) -> void:
	velocity.y += _gravity * delta
	move_and_slide()
	if is_on_floor() or is_on_ceiling():
		print("die")
		die()

	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fly"):
		velocity.y = FLY_FORCE
		animation_player.play("bounce")
	
func die() -> void:
	get_tree().paused = true
