@tool
extends MeshInstance3D

@export var path_node: Path3D  # Reference to the Path3D node with Curve3D
@export var track_width: float = 0.5  # Width of the track
@export var track_height: float = 0.1  # Height/thickness of the track
@export var segment_length: float = 0.3  # Length of each track segment
@export var material: Material  # Material for the tracks
@export var isDrawing: bool = false
@export var texture_speed: float = 1.0  # Speed of texture movement (units per second)
@export var texture_repeat: float = 1.0  # Texture repeat factor along track length

var uv_offset: float = 0.0  # Current UV offset for animation

func _ready():
	if not path_node or not path_node.curve:
		push_error("Path3D with Curve3D is required!")
		return
	path_node.curve.up_vector_enabled = true  # Ensure up vectors are enabled
	generate_tracks()

func _physics_process(delta: float) -> void:
	if isDrawing:
		# Update UV offset for texture animation
		#uv_offset = fmod(uv_offset + texture_speed * delta, texture_repeat)
		generate_tracks()
		uv_offset = fmod(uv_offset + texture_speed * delta, texture_repeat)

func generate_tracks():
	#mesh = ImmediateMesh.new()
	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES)
	
	var curve = path_node.curve
	var length = curve.get_baked_length()
	var steps = int(length / segment_length)
	
	# Get baked points and up vectors
	var baked_points = curve.get_baked_points()
	var baked_up_vectors = curve.get_baked_up_vectors()
	var point_count = baked_points.size()
	
	for i in range(steps + 1):
		var t = float(i) / steps
		var offset = t * length
		var pos = curve.sample_baked(offset)
		
		# Compute forward direction
		var forward = (curve.sample_baked(offset + 0.01) - pos).normalized()
		if forward.length() < 0.001: continue
		
		# Get up vector by interpolating baked up vectors
		var up_index = t * (point_count - 1)
		var index_floor = floor(up_index)
		var index_ceil = min(index_floor + 1, point_count - 1)
		var lerp_factor = up_index - index_floor
		var up = Vector3.UP  # Default fallback
		if curve.up_vector_enabled and baked_up_vectors.size() > 0 and index_ceil < baked_up_vectors.size():
			up = baked_up_vectors[index_floor].lerp(baked_up_vectors[index_ceil], lerp_factor).normalized()
		
		# Compute right vector and ensure orthogonality
		var right = forward.cross(up).normalized()
		up = right.cross(forward).normalized()  # Recompute up for orthogonality
		
		# Define cross-section vertices
		var v0 = pos + right * track_width * 0.5 + up * track_height * 0.5
		var v1 = pos + right * track_width * 0.5 - up * track_height * 0.5
		var v2 = pos - right * track_width * 0.5 - up * track_height * 0.5
		var v3 = pos - right * track_width * 0.5 + up * track_height * 0.5
		
		# UV coordinates for current segment with animation offset
		var u = (t * length / segment_length + uv_offset) * texture_repeat
		var uv0 = Vector2(u, 0.0)  # Top-right
		var uv1 = Vector2(u, 1.0)  # Bottom-right
		var uv2 = Vector2(u, 1.0)  # Bottom-left
		var uv3 = Vector2(u, 0.0)  # Top-left
		
		# Next segment
		var next_t = float(i + 1) / steps
		var next_pos = curve.sample_baked(next_t * length)
		var next_forward = (curve.sample_baked(next_t * length + 0.01) - next_pos).normalized()
		if next_forward.length() < 0.001: continue
		
		# Get next up vector
		var next_up_index = next_t * (point_count - 1)
		var next_index_floor = floor(next_up_index)
		var next_index_ceil = min(next_index_floor + 1, point_count - 1)
		var next_lerp_factor = next_up_index - next_index_floor
		var next_up = Vector3.UP
		if curve.up_vector_enabled and baked_up_vectors.size() > 0 and next_index_ceil < baked_up_vectors.size():
			next_up = baked_up_vectors[next_index_floor].lerp(baked_up_vectors[next_index_ceil], next_lerp_factor).normalized()
		
		var next_right = next_forward.cross(next_up).normalized()
		next_up = next_right.cross(next_forward).normalized()
		
		# Next segment vertices
		var v4 = next_pos + next_right * track_width * 0.5 + next_up * track_height * 0.5
		var v5 = next_pos + next_right * track_width * 0.5 - next_up * track_height * 0.5
		var v6 = next_pos - next_right * track_width * 0.5 - next_up * track_height * 0.5
		var v7 = next_pos - next_right * track_width * 0.5 + next_up * track_height * 0.5
		
		# UV coordinates for next segment with animation offset
		var next_u = (next_t * length / segment_length + uv_offset) * texture_repeat
		var uv4 = Vector2(next_u, 0.0)  # Top-right
		var uv5 = Vector2(next_u, 1.0)  # Bottom-right
		var uv6 = Vector2(next_u, 1.0)  # Bottom-left
		var uv7 = Vector2(next_u, 0.0)  # Top-left
		
		# Define triangles with counterclockwise winding for correct normals
		# Top face
		mesh.surface_set_uv(uv0); mesh.surface_add_vertex(v0)
		mesh.surface_set_uv(uv3); mesh.surface_add_vertex(v3)
		mesh.surface_set_uv(uv4); mesh.surface_add_vertex(v4)
		mesh.surface_set_uv(uv3); mesh.surface_add_vertex(v3)
		mesh.surface_set_uv(uv7); mesh.surface_add_vertex(v7)
		mesh.surface_set_uv(uv4); mesh.surface_add_vertex(v4)
		# Bottom face
		mesh.surface_set_uv(uv1); mesh.surface_add_vertex(v1)
		mesh.surface_set_uv(uv5); mesh.surface_add_vertex(v5)
		mesh.surface_set_uv(uv2); mesh.surface_add_vertex(v2)
		mesh.surface_set_uv(uv2); mesh.surface_add_vertex(v2)
		mesh.surface_set_uv(uv5); mesh.surface_add_vertex(v5)
		mesh.surface_set_uv(uv6); mesh.surface_add_vertex(v6)
		# Right side
		mesh.surface_set_uv(uv0); mesh.surface_add_vertex(v0)
		mesh.surface_set_uv(uv4); mesh.surface_add_vertex(v4)
		mesh.surface_set_uv(uv1); mesh.surface_add_vertex(v1)
		mesh.surface_set_uv(uv1); mesh.surface_add_vertex(v1)
		mesh.surface_set_uv(uv4); mesh.surface_add_vertex(v4)
		mesh.surface_set_uv(uv5); mesh.surface_add_vertex(v5)
		# Left side
		mesh.surface_set_uv(uv2); mesh.surface_add_vertex(v2)
		mesh.surface_set_uv(uv6); mesh.surface_add_vertex(v6)
		mesh.surface_set_uv(uv3); mesh.surface_add_vertex(v3)
		mesh.surface_set_uv(uv3); mesh.surface_add_vertex(v3)
		mesh.surface_set_uv(uv6); mesh.surface_add_vertex(v6)
		mesh.surface_set_uv(uv7); mesh.surface_add_vertex(v7)
	
	mesh.surface_end()
	if material:
		mesh.surface_set_material(0, material)
