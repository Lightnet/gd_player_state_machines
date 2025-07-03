extends BotState

#@onready var font : Font = global

@export var move_speed: float = 4.0
@export var rotation_speed: float = 5.0  # For smooth rotation
@export var point_threshold: float = 0.6  # Distance to consider a point reached

var points: PackedVector3Array  # Baked points from the Path3D curve
var current_point_index: int = 0  # Index of the current target point

func enter(_previous_state_path: String, _data := {}) -> void:
	# Initialize path points
	if not bot.path or not bot.path.curve:
		print("Path or curve is null")
		return
	points = bot.path.curve.get_baked_points()
	if points.size() < 2:
		print("Not enough points in path")
		return
	current_point_index = 0
	print("Following path with ", points.size(), " points")

func exit() -> void:
	points.clear()
	current_point_index = 0

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if points.size() < 2:
		return

	# Get the current target point
	var target_point: Vector3 = points[current_point_index]
	var bot_position: Vector3 = bot.global_position
	var distance_to_point: float = bot_position.distance_to(target_point)

	# Calculate direction to the target point (movement direction)
	var direction: Vector3 = (target_point - bot_position).normalized()

	# Move the bot
	bot.velocity = direction * move_speed
	bot.velocity.y = 0  # Keep bot on the ground (remove if gravity is needed)
	bot.move_and_slide()

	# Rotate to face 180 degrees opposite to the target point
	_look_at_next_point(delta)

	# Check if close enough to the current point
	if distance_to_point <= point_threshold:
		current_point_index += 1
		# Check if reached the end of the path
		if current_point_index >= points.size():
			#current_point_index = points.size() - 1  # Clamp to last point
			current_point_index = 0
			#finished.emit(self, "IdleState")  # Transition to idle state
			return

func _look_at_next_point(delta: float) -> void:
	# Use the current target point for rotation
	var target_point: Vector3 = points[current_point_index]
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
