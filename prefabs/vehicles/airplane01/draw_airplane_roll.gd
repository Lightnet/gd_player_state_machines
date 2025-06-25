extends Control

@export var vehicle: Node3D
#var line_points = []
@export var meter_needle: ColorRect
@export var max_roll_angle: float = 60.0  # Max displayable roll angle in degrees

func _process(delta):
	
	if vehicle:
		# Get roll angle in radians from the vehicle's transform
		var roll_radians = vehicle.transform.basis.get_euler().z
		# Convert to degrees and clamp
		var roll_degrees = clamp(rad_to_deg(roll_radians), -max_roll_angle, max_roll_angle)
		print("roll_degrees: " ,roll_degrees)
		# Apply rotation to silhouette (Sprite2D rotates in degrees)
		meter_needle.rotation_degrees = -roll_degrees  # Negative to match real-world behavior
	#if airplane:
		#var camera = get_viewport().get_camera_3d()
		#if camera:
			#var start_pos = camera.unproject_position(airplane.global_position)
			#var forward = -airplane.global_transform.basis.z
			#var end_pos = camera.unproject_position(airplane.global_position + forward * 10.0)
			#line_points = [start_pos, end_pos]
	
	#queue_redraw()

#func _draw():
	#if line_points.size() >= 2:
		## Check if the airplane is upside down
		#var is_upside_down = airplane.transform.basis.y.dot(Vector3.UP) < 0
		#var line_color = Color.RED if is_upside_down else Color.GREEN
		#draw_line(line_points[0], line_points[1], line_color, 2.0)
