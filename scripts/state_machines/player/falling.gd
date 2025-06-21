extends PlayerState

var isGround:bool = false

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = -player.jump_impulse
	#player.animation_player.play("jump")
	isGround=true

func physics_update(delta: float) -> void:
	#print("fall > is floor: ", player.is_on_floor())
	#var input_direction_x := Input.get_axis("left", "right")
	#player.velocity.x = player.speed * input_direction_x
	
	var input_dir = Input.get_vector("left","right","forward","backward",-1.0)
	print("input_dir: ",input_dir)
	
	var direction = (player.transform.basis * Vector3(input_dir.x,0,input_dir.y)).normalized()
	print("direction: ",direction)
	if direction:
		player.velocity.x = (direction.x * player.speed)
		player.velocity.z = (direction.z * player.speed)
	
	player.velocity.y += player.gravity * delta
	
	#if player.is_on_floor() and isGround == false:
	if player.is_on_floor():
		finished.emit(IDLE)
	if player.velocity.y >= 0:
		finished.emit(FALLING)

	player.move_and_slide()
