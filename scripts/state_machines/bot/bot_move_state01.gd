extends BotState
# Testing move base on progress
# does work but speed vs physics character move speed may different
@export var move_speed: float = 4.0
@export var path_threshold: float = 0.5  # Distance to consider a point reached

var current_progress: float = 0.0  # Current progress along the path (0.0 to 1.0)
var path_length: float = 0.0  # Total length of the path

func enter(_previous_state_path: String, _data := {}) -> void:
	# bot is Character3D, with var path for path3d
	path_length = bot.path.curve.get_baked_length()
	print("path_length: ", path_length)
	current_progress = 0.0
	#pass
	
func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if not bot.path or not bot.path.curve:
		print("bot path null")
		return
	print("current_progress:", current_progress)
	current_progress += 0.001
	# Calculate the target point using sample_baked
	var target_offset = current_progress * path_length
	var target_point = bot.path.curve.sample_baked(target_offset)
	var bot_position = bot.global_position
	
	# Calculate direction to the target point
	var direction = (target_point - bot_position).normalized()
	var distance_to_point = bot_position.distance_to(target_point)
	
	 # Check if close enough to the current point
	if distance_to_point < path_threshold:
		current_progress += delta * move_speed / path_length
		# Check if reached the end of the path
		if current_progress >= 1.0:
			current_progress = 1.0
			#finished.emit("IdleState")  # Transition to idle state
			return
		# Look at the next point
		#_look_at_next_point()
	_look_at_next_point()

	# Move the bot
	bot.velocity = direction * move_speed
	bot.velocity.y = 0  # Keep bot on the ground (adjust if gravity is needed)
	bot.move_and_slide()
	
	pass

func _look_at_next_point() -> void:
	# Get the next point slightly ahead on the path
	var look_offset = min(current_progress + 0.01, 1.0) * path_length
	var look_point = bot.path.curve.sample_baked(look_offset)
	
	# Calculate direction to the next point, projected onto the XZ plane
	var direction = (look_point - bot.global_position)
	direction.y = 0  # Ignore Y-component to keep bot upright
	direction = -direction.normalized()
	
	# Only rotate if direction is valid
	if direction.length() > 0:
		# Calculate the target Y rotation (angle around Y-axis)
		var target_y_rotation = atan2(direction.x, direction.z)
		# Apply rotation only on Y-axis
		bot.rotation.y = target_y_rotation

#func _look_at_next_point() -> void:
	## Get the next point slightly ahead to face
	#var look_progress = min(current_progress + 0.01, 1.0)
	#var look_point = bot.path.curve.sample_baked(look_progress * path_length)
	#var look_direction = (look_point - bot.global_position).normalized()
	#if look_direction.length() > 0:
		## Make the bot face the direction (only rotate on Y-axis)
		#bot.look_at(bot.global_position + look_direction, Vector3.UP)
