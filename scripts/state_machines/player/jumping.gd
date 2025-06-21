extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	#player.animation_player.play("fall")
	player.velocity.y = player.jump_impulse
	#player.velocity.y = 10
	#pass

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("left", "right")
	#player.velocity.x = player.speed * input_direction_x
	var input_dir = Input.get_vector("left","right","forward","backward",-1.0)
	print("input_dir: ",input_dir)
	
	var direction = (player.transform.basis * Vector3(input_dir.x,0,input_dir.y)).normalized()
	print("direction: ",direction)
	
	if direction:
		player.velocity.x = (direction.x * player.speed)
		player.velocity.z = (direction.z * player.speed)
	
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if player.is_on_floor():
		if is_equal_approx(input_direction_x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
	elif player.velocity.y <= 0:
		finished.emit(FALLING)
	print("player.velocity.y: ", player.velocity.y)
