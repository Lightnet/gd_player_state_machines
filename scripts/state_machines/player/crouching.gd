extends PlayerState
#CROUCHING

func enter(_previous_state_path: String, _data := {}) -> void:
	
	if player.collision_shape and player.collision_shape.shape is CapsuleShape3D:
		player.collision_shape.shape.height = player.original_shape_height * player.CROUCH_HEIGHT_SCALE
		player.collision_shape.shape.radius = player.original_shape_radius * player.CROUCH_RADIUS_SCALE
		# adjust position when crouch position update
		var height_difference = (player.original_shape_height - player.collision_shape.shape.height)/2
		player.position.y -= height_difference
	
	#if player.mesh_instance:
		#player.mesh_instance.position.y = player.original_mesh_position.y * player.CROUCH_HEIGHT_SCALE
	if player.neck:
		player.neck.position.y = player.original_neck_position.y * player.CROUCH_HEIGHT_SCALE
	pass

func exit()->void:
	if player.collision_shape and player.collision_shape.shape is CapsuleShape3D:
		player.collision_shape.shape.height = player.original_shape_height
		player.collision_shape.shape.radius = player.original_shape_radius
		
		player.position.y = player.original_position_y
	#if player.mesh_instance:
		#player.mesh_instance.position = player.original_mesh_position
	
	if player.neck:
		player.neck.position = player.original_neck_position
	pass

func handle_input(event: InputEvent) -> void:
	
	if event.is_action_released("crouch"):
		finished.emit(IDLE)
		#pass
	#pass

func physics_update(_delta: float) -> void:
	
	pass
