extends VehicleBody3D
# https://www.youtube.com/watch?v=7URoi0fSpnc

@onready var fr_wheel: VehicleWheel3D = $FR_Wheel
@onready var fl_wheel: VehicleWheel3D = $FL_Wheel
@export var propellor:Node3D

var horse_power  = 240
var accel_speed = 40

var steer_angle = deg_to_rad(30)

var steer_speed = 3

var brake_power = 40
var brake_speed = 40

var grounded = false

func _physics_process(delta):
	var throt_input = Input.get_action_strength("forward")+Input.get_action_strength("backward")
	engine_force = lerp(engine_force, throt_input*horse_power,accel_speed*delta )
	
	var steer_input = -Input.get_action_strength("right")+Input.get_action_strength("left")
	steering = lerp(steering,steer_input*steer_angle, steer_speed*delta)
	
	var brake_input = Input.get_action_strength("brake")
	brake = brake_input*brake_power

func _integrate_forces(_state):
	#var speed = transform.basis * linear_velocity
	var vec = transform.basis.z * linear_velocity
	var rez_vec = vec.x + vec.y + vec.z
	
	
	if grounded == true && Input.is_action_pressed("shift"):
		#if transform.basis.xform_inv(linear_velocity).z <= -8:
		if rez_vec <= -8:
			grounded = false
		if not fr_wheel.is_in_contact() && not fl_wheel.is_in_contact():
			grounded = false
	else:
		if fr_wheel.is_in_contact() && fl_wheel.is_in_contact():
			grounded = true
	
	if grounded == false:
		
		if rez_vec <= -6:
			linear_velocity = lerp(linear_velocity,-transform.basis.z*(horse_power/20),(accel_speed/20))
			
		var ver_input = -Input.get_action_strength("forward")+Input.get_action_strength("backward")
		var hor_input = -Input.get_action_strength("left")+Input.get_action_strength("right")
		angular_velocity = lerp(angular_velocity,(-transform.basis.x*ver_input)+(-transform.basis.z*hor_input),0.1)
		
		engine_force = 0
		steering = 0
		brake = 0

	propellor.rotation.z += 0.4
