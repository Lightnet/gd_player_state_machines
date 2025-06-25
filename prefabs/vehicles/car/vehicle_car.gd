extends VehicleBody3D

class_name VehicleController
@onready var camera: Camera3D = $Camera3D
@export var exit_point: Node3D
@onready var exit_time: Timer = $exit_time

# store player
var player
@export var IS_CONTROLLER:bool = false
var is_exit:bool = false

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
	#var property_list = get_property_list()
	#
	#for property in property_list:
		## Check for script variables (excludes built-in properties)
		#if property.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			#print("Script Variable: ", property.name)

func _unhandled_input(event: InputEvent) -> void:
	if not IS_CONTROLLER:
		return
	if event.is_action_pressed("interact") and is_exit == true:
		print("car exit")
		IS_CONTROLLER = false
		#player.enable_controller()
		#player.visible = true
		#player.set_process_input(true)
		player.exit_vehicle_show()
		player.global_position = exit_point.global_position
		player=null

func _physics_process(delta: float) -> void:
	
	if not IS_CONTROLLER:
		return
		
	_handle_input(delta)
	_apply_forces()
	#print("Velocity: ", linear_velocity.length())
	#if current_brake_force > 0:
		#print("Brake force: ", current_brake_force, " | Engine force: ", current_engine_force)
	#elif current_engine_force != 0:
		#print("Engine force: ", current_engine_force)

func _handle_input(delta: float) -> void:
	
	if not IS_CONTROLLER:
		return
		
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
	#print("accel_input: ", accel_input)
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

func player_interact(current_player=null) -> void:
	print("car current_player: ",current_player)
	
	if not current_player:
		return
	
	print("IS_CONTROLLER: ",current_player.get("IS_CONTROLLER"))
	
	#if current_player.get("IS_CONTROLLER"):
	#if does_variable_exist(current_player, "IS_CONTROLLER"):
	if current_player.has_method("disable_controller"):
		print("Found IS_CONTROLLER")
		#current_player.disable_controller()
		#current_player.set_process(false)
		#current_player.visible = false
		#current_player.set_process_input(false)
		player=current_player
		player.enter_vehicle_hide()
		
		enable_controller()
		exit_time.start()
		is_exit = false
		#pass
	else:
		print("NO IS_CONTROLLER")
	pass
#
func does_variable_exist(_node,var_name: String) -> bool:
	#var my_script = self.get_script()
	#var property_list = my_script.get_property_list()
	var property_list = _node.get_property_list()
	
	for property in property_list:
		if property.name == var_name and property.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			return true
	return false
	
func disable_controller()->void:
	IS_CONTROLLER = false
	#camera.dis
	#pass
	
func enable_controller()->void:
	IS_CONTROLLER = true
	camera.make_current()

func _on_exit_time_timeout() -> void:
	print("exit ready...")
	is_exit = true
	#pass
