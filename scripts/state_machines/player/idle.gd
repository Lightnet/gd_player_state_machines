extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0
	#player.velocity.y = 0.0
	player.velocity.z = 0.0
	#player.animation_player.play("idle")
	pass

func physics_update(_delta: float) -> void:
	#print("idle: ", player.is_on_floor())
	if !player.is_on_floor():
		player.velocity.y += (player.gravity * -1) * _delta
		#print("GRAVITY???")
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("forward") or Input.is_action_just_pressed("backward"):
		finished.emit(RUNNING)
	elif Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		finished.emit(RUNNING)
	elif Input.is_action_pressed("jump"):
		finished.emit(JUMPING)
