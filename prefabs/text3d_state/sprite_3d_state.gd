extends Sprite3D

@export var player:CharacterBody3D
@export var label_state: Label

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	var camera = get_viewport().get_camera_3d()
	if camera:  # Ensure the camera exists
		var sprite_pos = global_position
		var camera_pos = camera.global_position
		sprite_pos.y = 0
		camera_pos.y = 0
		# Calculate the direction vector
		var direction = (camera_pos - sprite_pos).normalized()
		# Calculate the angle to rotate on Y-axis
		var angle = atan2(direction.x, direction.z)
		# Apply rotation only on Y-axis
		rotation = Vector3(0, angle + deg_to_rad(180), 0)
	
	#var camera = get_viewport().get_camera_3d()
	#if camera:  # Ensure the camera exists
		#look_at(camera.global_position, Vector3.UP)
		## Rotate 180 degrees around the Y-axis to correct the orientation
		#rotate_y(deg_to_rad(180))
		
	if player and label_state:
		label_state.text = str(player.statemachine.state.name)
	pass
