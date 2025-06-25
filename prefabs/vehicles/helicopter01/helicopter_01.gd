# https://www.youtube.com/watch?v=KXhwSLqEYAI
extends VehicleBody3D

@export var horse_power  = 50
@export var accel_speed = 10

var steer_angle = deg_to_rad(30)
@export var steer_speed = 3

@export var brake_power = 40
@export var brake_speed = 40

var grounded = false

@export var main_propellor_path : NodePath
@export var back_propellor_path : NodePath

@export var right_wheel_path : NodePath
@export var left_wheel_path : NodePath
@export var front_wheel_path : NodePath

@onready var main_propellor = get_node(main_propellor_path)
@onready var back_propellor = get_node(back_propellor_path)

@onready var right_wheel = get_node(right_wheel_path)
@onready var left_wheel = get_node(left_wheel_path)
@onready var front_wheel = get_node(front_wheel_path)

func _physics_process(delta):
	var throt_input = Input.get_action_strength("forward")+Input.get_action_strength("backward")
	engine_force = lerp(engine_force, throt_input*horse_power,accel_speed*delta )
	
	var steer_input = -Input.get_action_strength("right")+Input.get_action_strength("left")
	steering = lerp_angle(steering,steer_input*steer_angle, steer_speed*delta)
	
	var brake_input = Input.get_action_strength("brake")
	brake = lerp(brake, brake_input*brake_power, brake_speed*delta)
	
func _integrate_forces(_state):
	
	#inputs
	var ver_input = -Input.get_action_strength("forward")+Input.get_action_strength("backward")
	var hor_input = -Input.get_action_strength("left")+Input.get_action_strength("right")
	#print("grounded: ", grounded)
	#landing/take off
	if grounded == true:
		if Input.is_action_pressed("brake") and ver_input == -1:
			grounded = false
	else:
		engine_force = 0
		steering = 0
		brake = 0
		if right_wheel.is_in_contact() or left_wheel.is_in_contact() or front_wheel.is_in_contact():
			grounded = true
			
	#air_movement
	if grounded == false && abs(rotation_degrees.x) <= 90 && abs(rotation_degrees.z) <= 90:
		if Input.is_action_pressed("brake"):
			linear_velocity.y =-ver_input * transform.basis.y.y * (horse_power/20)
			angular_velocity = Vector3.ZERO
			angular_velocity.y = -hor_input
		else:
			linear_velocity.y = 0
			angular_velocity =(transform.basis.x * ver_input)+(-transform.basis.z * hor_input)
		linear_velocity.x = transform.basis.y.x * (horse_power/5)
		linear_velocity.z = transform.basis.y.z * (horse_power/5)

	#animation
	main_propellor.rotation.y += 0.4
	back_propellor.rotation.x -= 0.4
