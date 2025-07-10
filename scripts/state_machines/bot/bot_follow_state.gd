extends BotState

var target_point:Vector3
@export var move_speed: float = 4.0
@export var rotation_speed: float = 5.0  # For smooth rotation
@export var point_threshold: float = 1.5  # Distance to consider a point reached
@export var out_range: float = 5.0  # Distance out range to stop follow

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
		target_point = bot.target.global_position
		var bot_position: Vector3 = bot.global_position
		
		var distance_to_point: float = bot_position.distance_to(target_point)
		# Calculate direction to the target point (movement direction)
		var direction: Vector3 = (target_point - bot_position).normalized()
		
		#print("distance_to_point: ",distance_to_point,"point_threshold: ", point_threshold)
		# Check if close enough to the current point
		# if close target
		if distance_to_point <= point_threshold:
			#print("bot.hand_right: " , bot.hand_right)
			#if bot.hand_right:
				#if bot.hand_right.has_method("set_attack_enabled"):
					##print("attack " )
					#bot.hand_right.set_attack_enabled(true)
			#if bot.behaviour_mode == "argo":
				#finished.emit(ATTACK)
			#pass
			finished.emit(ATTACK)
		elif distance_to_point >= out_range:
			finished.emit(DETECT)
			pass
		else:
			#if bot.hand_right:
				#if bot.hand_right.has_method("set_attack_enabled"):
					#bot.hand_right.set_attack_enabled(false)
			# Move the bot
			bot.velocity = direction * move_speed
			bot.velocity.y = 0  # Keep bot on the ground (remove if gravity is needed)
			bot.move_and_slide()
			
		_look_at_next_point(delta)
	
	pass

func _look_at_next_point(delta: float) -> void:
	# Use the current target point for rotation
	#var target_point: Vector3 = points[current_point_index]
	#var target_point = target_position
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
