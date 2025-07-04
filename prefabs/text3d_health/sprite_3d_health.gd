extends Sprite3D

@export var player:CharacterBody3D
@export var label_health:Label
@export var label_health_max:Label

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
		
		if player and label_health and label_health_max:
			label_health.text = str(player.stats.health)
			label_health_max.text = str(player.stats.health_max)
	pass
