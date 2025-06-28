extends Node3D
# static mesh collision test
# working

# Used for checking if the mouse is inside the Area3D.
#var is_mouse_inside = false
# The last processed input touch/mouse event. To calculate relative movement.
#var last_event_pos2D = null
# The time of the last event in seconds since engine start.
#var last_event_time: float = -1.0

@onready var camera: Camera3D = $Camera3D
@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var sub_viewport: SubViewport = $SubViewport
#@onready var node_area: Area3D = $Sprite3D/Area3D

func _ready():
	pass

func _input(event: InputEvent) -> void:
	pass
	
func _unhandled_input(event):
	# Check if the event is a non-mouse/non-touch event
	#for mouse_event in [InputEventMouseButton, InputEventMouseMotion, InputEventScreenDrag, InputEventScreenTouch]:
		#if is_instance_of(event, mouse_event):
			## If the event is a mouse/touch event, then we can ignore it here, because it will be
			## handled via Physics Picking.
			#return
	#print("_unhandled_input")
	#var pos2d = get_mouse_position()
	#print("pos2d: ", pos2d)
	if event is InputEventMouseMotion:
		var pos2d = get_mouse_position()
		event.position = pos2d
		event.global_position = pos2d
	if event is InputEventMouse:
		var pos2d = get_mouse_position()
		event.position = pos2d
		event.global_position = pos2d
	# input text
	sub_viewport.push_input(event)

func _mouse_input_event(_camera: Camera3D, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int):
	#print(event)
	if event is InputEventMouseMotion:
		var pos2d = get_mouse_position()
		event.position = pos2d
		event.global_position = pos2d
	if event is InputEventMouse:
		var pos2d = get_mouse_position()
		event.position = pos2d
		event.global_position = pos2d
	# Finally, send the processed input event to the viewport.
	sub_viewport.push_input(event)
	#pass

# get static collision to convert base on subviewport
func get_mouse_position()->Vector2:
	var mouse_pos = get_viewport().get_mouse_position()
	var mouse_pos_2d:Vector2
	# Step 1: Raycast from camera to 3D world
	var ray_length = 1000.0
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	#print("mouse_pos: ", mouse_pos)
	
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	#query.collision_mask = 1  # Adjust to match Sprite3D's collision layer
	var result = space_state.intersect_ray(query)
	#print(result)
	
	if not result.is_empty():
		#print("position: ", result["position"])
		# Get the 3D collision point
		var collision_point = result.position
		# Step 3: Convert 3D collision point to SubViewport 2D coordinates
		var local_point = sprite_3d.to_local(collision_point)
		#print("local_point: ", local_point)
		var sprite_size = sprite_3d.pixel_size * sprite_3d.texture.get_size()  # Size in 3D world units
		var subviewport_size = sub_viewport.size  # SubViewport resolution (e.g., 320x180)
		
		# Normalize the local point to UV coordinates (0 to 1)
		var uv = Vector2(
			(local_point.x / sprite_size.x + 0.5),
			(-local_point.y / sprite_size.y + 0.5)  # Y is inverted
		)
		
		# Convert UV to SubViewport pixel coordinates
		mouse_pos_2d = Vector2(
			uv.x * subviewport_size.x,
			uv.y * subviewport_size.y
		)
		#sub_viewport
		print("mouse_pos_2d:", mouse_pos_2d)
		
	return mouse_pos_2d

func _on_button_pressed() -> void:
	print("click in sub viewport")
	pass
