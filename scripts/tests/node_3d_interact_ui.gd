extends Node3D


@onready var node_viewport: SubViewport = $SubViewport
@onready var node_quad: Sprite3D = $Sprite3D
@onready var node_area:Area3D = $Sprite3D/Area3D

# Used for checking if the mouse is inside the Area3D.
var is_mouse_inside = false
# The last processed input touch/mouse event. To calculate relative movement.
var last_event_pos2D = null

var ray_length: float = 100.0

func _ready() -> void:
	node_area.mouse_entered.connect(_mouse_entered_area)
	node_area.mouse_exited.connect(_mouse_exited_area)
	node_area.input_event.connect(_mouse_input_event)
	pass

func _input(event):
	if event is InputEventMouseMotion:
		
		node_viewport.get_viewport().push_input(event)#event push and convert?
		
		
		#var camera: Camera3D = sub_viewport.get_viewport().get_camera_3d()
		var camera: Camera2D = node_viewport.get_viewport().get_camera_2d()
		if not camera:
			print("No camera found!")
			return
			
		var sub_mouse_position = node_viewport.get_viewport().get_mouse_position()
		
		#var mouse_position = (sub_mouse_position - texture_rect_pos) * size_ratio
		
		var mouse_position = sub_mouse_position
		
		# Get SubViewport size and clamp mouse position
		var viewport_size = node_viewport.size
		mouse_position.x = clamp(mouse_position.x, 0, viewport_size.x)
		mouse_position.y = clamp(mouse_position.y, 0, viewport_size.y)
		
		# Calculate ray origin and direction using viewport coordinates
		var origin: Vector3 = camera.project_ray_origin(mouse_position)
		var direction: Vector3 = camera.project_ray_normal(mouse_position)
		var end: Vector3 = origin + direction * ray_length
		
		# Perform raycast
		var space = camera.get_world_3d().direct_space_state
		var ray_query = PhysicsRayQueryParameters3D.create(origin, end)
		var raycast_result = space.intersect_ray(ray_query)
			
		if not raycast_result.is_empty():
			print("position: ", raycast_result["position"])
			#pointer.global_position = raycast_result["position"]
		pass

func _process(delta: float) -> void:
	
	pass

func _on_button_pressed() -> void:
	print("click...")
	pass

func _mouse_entered_area():
	is_mouse_inside = true

func _mouse_exited_area():
	is_mouse_inside = false
	
func _mouse_input_event(_camera: Camera3D, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int):
	
	# Get mesh size to detect edges and make conversions. This code only support PlaneMesh and QuadMesh.
	var quad_mesh_size:Vector2 = node_quad.get_region_rect().size
	#print("quad_mesh_size: ", quad_mesh_size)
	print("node_quad.get_region_rect(): ", node_quad.get_region_rect())
	quad_mesh_size.x =1
	quad_mesh_size.y =1
	
	# Event position in Area3D in world coordinate space.
	var event_pos3D = event_position
	#print("event_pos3D: ", event_pos3D)
	
	# Current time in seconds since engine start.
	var now: float = Time.get_ticks_msec() / 1000.0
	
	# Convert position to a coordinate space relative to the Area3D node.
	# NOTE: affine_inverse accounts for the Area3D node's scale, rotation, and position in the scene!
	event_pos3D = node_quad.global_transform.affine_inverse() * event_pos3D
	
	var event_pos2D: Vector2 = Vector2()
	
	
	#if is_mouse_inside:
		## Convert the relative event position from 3D to 2D.
		#event_pos2D = Vector2(event_pos3D.x, -event_pos3D.y)
		#
		## Right now the event position's range is the following: (-quad_size/2) -> (quad_size/2)
		## We need to convert it into the following range: -0.5 -> 0.5
		#event_pos2D.x = event_pos2D.x / quad_mesh_size.x
		#event_pos2D.y = event_pos2D.y / quad_mesh_size.y
		## Then we need to convert it into the following range: 0 -> 1
		#event_pos2D.x += 0.5
		#event_pos2D.y += 0.5
#
		## Finally, we convert the position to the following range: 0 -> viewport.size
		#event_pos2D.x *= node_viewport.size.x
		#event_pos2D.y *= node_viewport.size.y
		## We need to do these conversions so the event's position is in the viewport's coordinate system.
	#elif last_event_pos2D != null:
		## Fall back to the last known event position.
		#event_pos2D = last_event_pos2D
		#
	#print("event_pos2D: ", event_pos2D)

	pass
