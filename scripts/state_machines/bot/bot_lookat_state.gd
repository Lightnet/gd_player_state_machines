extends BotState

var target_position:Vector3
@export var rotation_speed: float = 5.0  # For smooth rotation

func enter(_previous_state_path: String, _data := {}) -> void:
	pass
	
func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	
	if bot.target:
		target_position = bot.target.global_position
		_look_at_next_point(delta)
	
	pass

func _look_at_next_point(delta: float) -> void:
	# Use the current target point for rotation
	#var target_point: Vector3 = points[current_point_index]
	var target_point = target_position
	var bot_position: Vector3 = bot.global_position

	# Calculate direction to the target point, projected onto the XZ plane
	var direction: Vector3 = (target_point - bot_position)
	direction.y = 0  # Ignore Y-component to keep bot upright
	direction = -direction.normalized()  # Face 180 degrees opposite

	# Only rotate if direction is valid
	if direction.length() > 0:
		# Calculate the target Y rotation (angle around Y-axis)
		var target_y_rotation: float = atan2(direction.x, direction.z)
		# Smoothly apply rotation only on Y-axis
		bot.rotation.y = lerp_angle(bot.rotation.y, target_y_rotation, rotation_speed * delta)
