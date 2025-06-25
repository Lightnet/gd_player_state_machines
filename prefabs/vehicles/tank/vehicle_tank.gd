extends VehicleBody3D

class_name VehicleTank
@onready var camera: Camera3D = $Camera3D
@export var exit_point: Node3D
@onready var exit_time: Timer = $exit_time

# Store player
var player
@export var IS_CONTROLLER: bool = false
var is_exit: bool = false

# Configuration variables
var max_engine_force: float = 200.0
var max_brake_force: float = 100.0
var acceleration: float = 100.0      # Increased for faster response
var brake_strength: float = 10.0
var idle_deceleration: float = 100.0 # Increased for faster reset

# New tank-specific variables
var max_left_track_force: float = 200.0
var max_right_track_force: float = 200.0

# Node references
@onready var wheel_front_left: VehicleWheel3D = $WheelFront_Left
@onready var wheel_front_right: VehicleWheel3D = $WheelFront_Right
@onready var wheel_rear_right: VehicleWheel3D = $WheelRear_Right
@onready var wheel_rear_left: VehicleWheel3D = $WheelRear_Left

# Runtime variables
var left_track_force: float = 0.0
var right_track_force: float = 0.0
var current_brake_force: float = 0.0

func _ready() -> void:
	if not wheel_front_left or not wheel_front_right or not wheel_rear_left or not wheel_rear_right:
		push_error("One or more wheel nodes are missing!")
	# Ensure wheels don't steer (tank tracks don't pivot like car wheels)
	wheel_front_left.steering = 0.0
	wheel_front_right.steering = 0.0
	wheel_rear_left.steering = 0.0
	wheel_rear_right.steering = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if not IS_CONTROLLER:
		return
	if event.is_action_pressed("interact") and is_exit == true:
		print("car exit")
		IS_CONTROLLER = false
		player.exit_vehicle_show()
		player.global_position = exit_point.global_position
		player = null

func _physics_process(delta: float) -> void:
	if not IS_CONTROLLER:
		return
	_handle_input(delta)
	_apply_forces()

func _handle_input(delta: float) -> void:
	if not IS_CONTROLLER:
		return

	# Initialize track inputs
	var left_track_input: float = 0.0
	var right_track_input: float = 0.0

	# Braking
	var brake_input: float = Input.get_action_strength("brake")
	if brake_input > 0:
		print("Brake input: ", brake_input)
		current_brake_force = move_toward(current_brake_force, max_brake_force * brake_input, brake_strength * delta)
	else:
		current_brake_force = move_toward(current_brake_force, 0.0, brake_strength * delta)

	# Movement and turning inputs
	var move_input: float = Input.get_axis("backward", "forward")  # Positive for forward, negative for backward
	var turn_input: float = Input.get_axis("left", "right")       # Positive for right, negative for left

	if brake_input > 0:
		# Braking overrides all movement
		left_track_input = 0.0
		right_track_input = 0.0
	else:
		if turn_input != 0.0:
			# Turning takes precedence: left/right inputs set opposing track forces
			if turn_input > 0:  # Right turn
				left_track_input = 1.0   # Left track forward
				right_track_input = -1.0 # Right track backward
			else:  # Left turn
				left_track_input = -1.0  # Left track backward
				right_track_input = 1.0  # Right track forward
		else:
			# No turning: both tracks move based on forward/backward input
			left_track_input = move_input
			right_track_input = move_input

	# Smoothly adjust track forces
	left_track_force = move_toward(left_track_force, max_left_track_force * left_track_input, acceleration * delta)
	right_track_force = move_toward(right_track_force, max_right_track_force * right_track_input, acceleration * delta)

func _apply_forces() -> void:
	# Apply forces to left-side wheels
	wheel_front_left.engine_force = left_track_force
	wheel_rear_left.engine_force = left_track_force
	# Apply forces to right-side wheels
	wheel_front_right.engine_force = right_track_force
	wheel_rear_right.engine_force = right_track_force
	# Apply braking to all wheels
	wheel_front_left.brake = current_brake_force
	wheel_front_right.brake = current_brake_force
	wheel_rear_left.brake = current_brake_force
	wheel_rear_right.brake = current_brake_force

func player_interact(current_player = null) -> void:
	print("car current_player: ", current_player)
	
	if not current_player:
		return
	
	if current_player.has_method("disable_controller"):
		print("Found IS_CONTROLLER")
		player = current_player
		player.enter_vehicle_hide()
		enable_controller()
		exit_time.start()
		is_exit = false
	else:
		print("NO IS_CONTROLLER")

func does_variable_exist(_node, var_name: String) -> bool:
	var property_list = _node.get_property_list()
	for property in property_list:
		if property.name == var_name and property.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			return true
	return false

func disable_controller() -> void:
	IS_CONTROLLER = false

func enable_controller() -> void:
	IS_CONTROLLER = true
	camera.make_current()

func _on_exit_time_timeout() -> void:
	print("exit ready...")
	is_exit = true
