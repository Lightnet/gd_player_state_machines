extends Sprite3D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	var camera = get_viewport().get_camera_3d()
	if camera:  # Ensure the camera exists
		look_at(camera.global_position, Vector3.UP)
		# Rotate 180 degrees around the Y-axis to correct the orientation
		rotate_y(deg_to_rad(180))
	pass
