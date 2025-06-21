extends Node

#func _ready() -> void:
	#pass

#func _process(delta: float) -> void:
	#pass

func line(pos1:Vector3, pos2:Vector3,color = Color.WHITE_SMOKE) -> MeshInstance3D:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = 0 #false
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(pos1)
	immediate_mesh.surface_add_vertex(pos2)
	immediate_mesh.surface_end()
	
	get_tree().get_root().add_child(mesh_instance)
	
	return mesh_instance

func point(pos:Vector3,radius = 0.05, color = Color.WHITE_SMOKE) -> MeshInstance3D:
	
	var mesh_instance:= MeshInstance3D.new()
	var sphere_mesh := SphereMesh.new()
	var material := ORMMaterial3D.new()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	mesh_instance.mesh = sphere_mesh
	mesh_instance.cast_shadow = 0 #false
	mesh_instance.position = pos
	
	sphere_mesh.radius = radius
	sphere_mesh.height = radius*2
	sphere_mesh.material = material
	
	get_tree().get_root().add_child(mesh_instance)
	
	return mesh_instance
	#pass 
