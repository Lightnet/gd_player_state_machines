extends Sprite3D

@export var player:CharacterBody3D
@export var label_health:Label
@export var label_health_max:Label

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	var camera = get_viewport().get_camera_3d()
	if camera:  # Ensure the camera exists
		look_at(camera.global_position, Vector3.UP)
		# Rotate 180 degrees around the Y-axis to correct the orientation
		rotate_y(deg_to_rad(180))
		
	if player and label_health and label_health_max:
		label_health.text = str(player.stats.health)
		label_health_max.text = str(player.stats.health_max)
	pass
