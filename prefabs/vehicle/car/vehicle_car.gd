extends VehicleBody3D

class_name VehicleController

# Configuration variables
var max_engine_force: float = 200.0
var max_brake_force: float = 100.0
var max_steering_angle: float = 30.0
var steering_speed: float = 3.0
var acceleration: float = 100.0      # Increased for faster response
var brake_strength: float = 10.0
var idle_deceleration: float = 100.0 # Increased for faster reset

# Node references
@onready var wheel_front_left: VehicleWheel3D = $WheelFront_Left
@onready var wheel_front_right: VehicleWheel3D = $WheelFront_Right
@onready var wheel_rear_right: VehicleWheel3D = $WheelRear_Right
@onready var wheel_rear_left: VehicleWheel3D = $WheelRear_Left

# Runtime variables
var current_steering: float = 0.0
var current_engine_force: float = 0.0
var current_brake_force: float = 0.0

func _ready() -> void:
	if not wheel_front_left or not wheel_front_right or not wheel_rear_left or not wheel_rear_right:
		push_error("One or more wheel nodes are missing!")

func _physics_process(delta: float) -> void:
	_handle_input(delta)
	_apply_forces()
	print("Velocity: ", linear_velocity.length())
	if current_brake_force > 0:
		print("Brake force: ", current_brake_force, " | Engine force: ", current_engine_force)
	elif current_engine_force != 0:
		print("Engine force: ", current_engine_force)

func _handle_input(delta: float) -> void:
	# Steering
	var steer_input: float = Input.get_axis("right", "left")
	var target_steering: float = deg_to_rad(max_steering_angle) * steer_input
	current_steering = move_toward(current_steering, target_steering, steering_speed * delta)
	
	# Braking
	var brake_input: float = Input.get_action_strength("brake")
	if brake_input > 0:
		print("Brake input: ", brake_input)
	current_brake_force = move_toward(current_brake_force, max_brake_force * brake_input, brake_strength * delta)
	
	# Acceleration (forward and backward)
	var accel_input: float = Input.get_axis("backward", "forward")
	print("accel_input: ", accel_input)
	if brake_input > 0:
		current_engine_force = 0.0
	else:
		# Optional: Reset engine force on direction change
		if (accel_input > 0 and current_engine_force < 0) or (accel_input < 0 and current_engine_force > 0):
			current_engine_force = 0.0
		current_engine_force = move_toward(current_engine_force, max_engine_force * accel_input, acceleration * delta)

func _apply_forces() -> void:
	wheel_front_left.steering = current_steering
	wheel_front_right.steering = current_steering
	wheel_front_left.engine_force = current_engine_force
	wheel_front_right.engine_force = current_engine_force
	wheel_rear_left.engine_force = current_engine_force
	wheel_rear_right.engine_force = current_engine_force
	wheel_front_left.brake = current_brake_force
	wheel_front_right.brake = current_brake_force
	wheel_rear_left.brake = current_brake_force
	wheel_rear_right.brake = current_brake_force
